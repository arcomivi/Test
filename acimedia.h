#ifndef ACIMEDIA_H
#define ACIMEDIA_H

#include <QObject>
#include "acilistmodel.h"
#include "acimusicplayer.h"

class ACIMedia : public QObject
{
    Q_OBJECT
public:
    explicit ACIMedia(QObject *parent = 0);
    ACIListModel* getModel();
    void loadMedia();

    void displayMusic();
    void displayInitialMusic();
    void displayAllSongs();

signals:
    void mediaChanged();
    void sendProgress(int);

public slots:
    void mediaModelClicked(Item itemClicked);
    void volup();
    void voldown();

private:
    enum {
        MEDIA_INITIAL = -1,
        MEDIA_MUSIC,
        MEDIA_VIDEO,
        MEDIA_PICTURE
    };

    enum {
        MUSIC_INITIAL = -1,
        MUSIC_ALL_SONGS,
        MUSIC_ARTIST_ALBUM_PATH,
        MUSIC_SONGS_ARTIST_ALBUM_PATH,
        MUSIC_PLAYLISTS,
        MUSIC_RECENTLY_PLAYED,
        MUSIC_ALL_ALBUMS,
        MUSIC_SONGS_ARTIST_ALBUM
    };

    int m_iMediaType;
    int m_iMusicType;
    ACIListModel *m_oMediaModel;
    ACIMusicPlayer *m_oMusicPlayer;
    QMediaPlaylist *m_musicPlayingPlaylist;
    QList<QMediaContent> m_songList;
    bool m_bNewPlaylist;
};

#endif // ACIMEDIA_H
