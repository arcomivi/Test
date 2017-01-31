#include "acimedia.h"

ACIMedia::ACIMedia(QObject *parent) : QObject(parent){
    m_iMediaType = MEDIA_INITIAL;
    m_iMusicType = MUSIC_INITIAL;
    m_oMediaModel = new ACIListModel();

    m_oMusicPlayer = new ACIMusicPlayer();
    m_musicPlayingPlaylist = new QMediaPlaylist();
    m_songList.clear();
    m_bNewPlaylist = true;

    connect(m_oMediaModel, SIGNAL(itemClicked(Item)), this, SLOT(mediaModelClicked(Item)));
}

ACIListModel *ACIMedia::getModel()
{
    return this->m_oMediaModel;
}

void ACIMedia::loadMedia()
{
    m_oMediaModel->removeRows(0, m_oMediaModel->rowCount());

    if(m_iMediaType==MEDIA_INITIAL){
        m_oMediaModel->addItem(Item("MEDIA_MUSIC", "Music", "music", "folder"));
        m_oMediaModel->addItem(Item("MEDIA_VIDEO", "Video", "video", "folder"));
        m_oMediaModel->addItem(Item("MEDIA_PICTURE", "Pictures", "picture", "folder"));
    } else if(m_iMediaType==MEDIA_MUSIC){
        if(m_iMusicType==MUSIC_INITIAL){
            displayInitialMusic();
        } else if(m_iMusicType==MUSIC_ALL_SONGS){
            displayAllSongs();
        }
    }

}

void ACIMedia::mediaModelClicked(Item itemClicked){
    TRACE(QString("Name: %1").arg(itemClicked.name()));
    TRACE(QString("Descr: %1").arg(itemClicked.descr()));
    TRACE(QString("Value: %1").arg(itemClicked.value()));
    QString name = itemClicked.name();
    if(name.compare("MEDIA_MUSIC")==0){
        m_iMediaType=MEDIA_MUSIC;
        displayMusic();
    } else if(name.compare("ALL_SONGS")==0){
        m_iMusicType=MUSIC_ALL_SONGS;
        displayMusic();
    } else if(name.compare("SONG")==0){
        if(m_bNewPlaylist){
            m_musicPlayingPlaylist->clear();
            m_musicPlayingPlaylist->addMedia(m_songList);
            m_musicPlayingPlaylist->setCurrentIndex(m_oMediaModel->getCurrentIndex()==0?0:m_oMediaModel->getCurrentIndex()-1);
            m_oMusicPlayer->setPlaylist(m_musicPlayingPlaylist);
            m_bNewPlaylist = false;
        }
        m_oMusicPlayer->playPause(m_oMediaModel->getCurrentIndex()==0?0:m_oMediaModel->getCurrentIndex()-1);
//        m_iMediaType = VIDEO_ALL_VIDEOS;
//        displayVideo();
    } else if(name.compare("ALL_PICTURES")==0){
//        m_iMediaType = PICTURE_PATH;
//        QString value = itemClicked.value();
//        displayPathPictures(value);
    }
    TRACE("exit");
}

/** ===============================
 *  displayMusic - description
 */
void ACIMedia::displayMusic() {
    TRACE(QString("enter: %1").arg(m_iMusicType));

    switch(m_iMusicType){
    case MUSIC_INITIAL:
        emit mediaChanged();
//        displayInitialMusic();
        break;
    case MUSIC_ALL_ALBUMS:
//        emit mediaChanged();
        break;
    case MUSIC_ALL_SONGS:
        emit mediaChanged();
        break;
    case MUSIC_SONGS_ARTIST_ALBUM:
//        displaySongsAlbumArtist();
        break;
    default:
        break;
    }
    TRACE("exit");
}

void ACIMedia::displayInitialMusic(){
    m_oMediaModel->removeRows(0, m_oMediaModel->rowCount());
    m_oMediaModel->addItem(Item("ALL_ALBUMS", "All Albums", "music", "folder"));
    m_oMediaModel->addItem(Item("ALL_ARTISTS", "All Artists", "music", "folder"));
    m_oMediaModel->addItem(Item("ALL_SONGS", "All Songs", "music", "folder"));
}

void ACIMedia::displayAllSongs(){
    m_bNewPlaylist = true;
    m_oMediaModel->removeRows(0, m_oMediaModel->rowCount());
    m_songList.clear();

    m_oMediaModel->addItem(Item(QLatin1String("( ... go up ... )"),"Go back to main list","go_back_to_main", "left"));

    QString music = QDir::homePath() + "/Music";
    QDir musicDir(music);
    if(musicDir.exists()){
        foreach (QString entry, musicDir.entryList()) {
            qDebug() << entry;
        }
        foreach (QFileInfo fileInfo, musicDir.entryInfoList()) {
            qDebug() << fileInfo.baseName();
            if (fileInfo.isDir()) {
                QString song = music + "/" + fileInfo.baseName();
                foreach (QFileInfo song, QDir(song).entryInfoList()) {
                    if (song.isDir()) {
                        continue;
                    }
                    qDebug() << "song: " << song.baseName();
                    qDebug() << "path: " << song.absoluteFilePath();
                    m_oMediaModel->addItem(Item("SONG", song.baseName(), song.absoluteFilePath()));

                    //build playlist at once
                    QUrl url(song.absoluteFilePath());
                    QMediaContent media(url);
                    m_songList.append(media);
                }
            }
        }
    } else {
        qDebug() << "does not exiswt";
    }
    foreach (const QStorageInfo &storage, QStorageInfo::mountedVolumes()) {
        if (storage.isValid() && storage.isReady()) {
            qDebug() << "name" << storage.name();
            qDebug() << "rootpath" << storage.rootPath();
            music = storage.rootPath() + "/Music";
            QDir musicDir(music);
            if(musicDir.exists()){
                foreach (QString entry, musicDir.entryList()) {
                    qDebug() << entry;
                }
                foreach (QFileInfo fileInfo, musicDir.entryInfoList()) {
                    qDebug() << fileInfo.baseName();
                    if (fileInfo.isDir()) {
                        QString song = music + "/" + fileInfo.baseName();
                        foreach (QFileInfo song, QDir(song).entryInfoList()) {
                            if (song.isDir()) {
                                continue;
                            }
                            qDebug() << "song: " << song.baseName();
                            qDebug() << "path: " << song.absoluteFilePath();
                            m_oMediaModel->addItem(Item("SONG", song.baseName(), song.absoluteFilePath()));

                            //build playlist at once
                            QUrl url(song.absoluteFilePath());
                            QMediaContent media(url);
                            m_songList.append(media);
                        }
                    }
                }
            }


        }
    }
}
