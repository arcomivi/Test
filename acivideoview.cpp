#include "acivideoview.h"

ACIVideoView::ACIVideoView(QQuickView *parent) :
    QQuickView(parent){

}

void ACIVideoView::setQmlFile(QString qml){
    this->setSource(QUrl(qml));
}

void ACIVideoView::keyPressEvent(QKeyEvent *e){
    if(e->key() == Qt::Key_W){ //UP
        QMetaObject::invokeMethod((QObject*)this->rootObject(), "handleDirUp", Qt::DirectConnection);
        return;
    }
    if(e->key() == Qt::Key_M){ //ROT1
        QMetaObject::invokeMethod((QObject*)this->rootObject(), "handleRot", Qt::DirectConnection, Q_ARG(QVariant, 0));
        return;
    }
    if(e->key() == Qt::Key_N){ //ROT2
        QMetaObject::invokeMethod((QObject*)this->rootObject(), "handleRot", Qt::DirectConnection, Q_ARG(QVariant, 1));
        return;
    }
    QQuickView::keyPressEvent(e);
}
