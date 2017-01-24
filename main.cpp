#include <QApplication>
#include <QGuiApplication>
#include <QScreen>
#include <QDesktopWidget>
#include "globalincludes.h"
#include "aciconfig.h"
#include "acimainview.h"
#include <QtMultimedia>
#include <QCameraInfo>
#include <QVideoWidget>
#include <QLabel>
#include <QImage>
#include <QPixmap>

//#include "qfoo.h"
//#include "acicamera.h"


int main(int argc, char *argv[]){


//    qmlRegisterType<ACICamera>("ACIElements", 1, 0, "ACICamera");

    foreach (const QCameraInfo &cameraInfo, QCameraInfo::availableCameras())    {
        qDebug() << "Camera: " << cameraInfo.deviceName();
    }



    TRACE_CONSOLE("Start...");
    QApplication a(argc, argv);
    a.setApplicationName("ArComIVI");
    QCoreApplication::setOrganizationName("ArCom-IVI");
    QCoreApplication::setOrganizationDomain("arcom-ivi.de");
    QCoreApplication::setApplicationName("ArComIVI");

//    Test with 2 cameras:
//    QFoo *bar = new QFoo(0);
//    bar->setGeometry(10,10,640,480);
//    bar->show();

//    QFoo *boo = new QFoo(1);
//    boo->setGeometry(700,10,640,480);
//    boo->show();

//    return a.exec();

    //==> set-up home path in config
    ACIConfig::instance()->setHomePath(QDir::homePath());


    //==> setup directory: $USER/.arcomivi
    //check if .arcomivi exists and if not, create it
    QDir arcom(ACIConfig::instance()->homePath()+".arcomivi");
    if(!arcom.exists()){
        QDir home(QDir::homePath());
        if(!home.mkdir(".arcomivi")){
            exit(-1);
        }
    }

    //==> set up initial logging
    //set log level to log everything
    ACILogger::getInstance()->setupLog();
    ACILogger::getInstance()->setLogLevel(3);
    ACILogger::getInstance()->setConsoleOut(true);

    ACIConfig::instance()->initConfig();



//==> read stylesheet data OBSOLETE
//    QFile file(ACIConfig::instance()->getCssFile());
//    file.open(QFile::ReadOnly);
//    QString styleSheet = QLatin1String(file.readAll());

//    ACIDialog w;
//    w.setWindowFlags(Qt::WindowStaysOnTopHint);

//    w.showFullScreen();
//    w.show();
    //w.setAttribute(Qt::WA_TranslucentBackground);
    //w.setAutoFillBackground(false);
    //w.setAttribute(Qt::WA_OpaquePaintEvent, true);
    //w.setAttribute(Qt::WA_NoSystemBackground);
//    qApp->setStyleSheet(styleSheet);
//    a.setStyleSheet("background-image: /usr/share/arcomivi/css/common/wallpaper640x480.png;");


    TRACE_CONSOLE("Start...READY=1");

//    gets information of the available desktops screens
    QDesktopWidget *desktopWidget = QApplication::desktop();

    ACIMainview *oMainview = new ACIMainview();
    oMainview->setQmlFile(ACIConfig::instance()->getQmlPrefix()+"MainView.qml");
    oMainview->setFlags(Qt::FramelessWindowHint);
    oMainview->setResizeMode(QQuickView::SizeRootObjectToView);

    oMainview->setGeometry(
                           700,
                           50,
                           640,
                           480
                           );
//    oMainview->setGeometry(
//                           0,
//                           0,
//                           desktopWidget->screenGeometry(0).width(),
//                           desktopWidget->screenGeometry(0).height()
//                           );
    oMainview->show();

    return a.exec();
}
