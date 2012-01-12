#-------------------------------------------------
#
# Project created by QtCreator 2012-01-07T00:30:52
#
#-------------------------------------------------

QT       += core gui opengl

TARGET = FrmWork
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    uglview.cpp \
    udlgholder.cpp \
    processtool.cpp \
    uprocessitem.cpp \
    uprocessitemmodify.cpp \
    sharedmemory.cpp \
    progressdlg.cpp

HEADERS  += mainwindow.h \
    uglview.h \
    udlgholder.h \
    processtool.h \
    uprocessitem.h \
    uprocessitemmodify.h \
    sharedmemory.h \
    progressdlg.h

FORMS    += mainwindow.ui \
    processtool.ui \
    uprocessitemmodify.ui \
    progressdlg.ui

RESOURCES += \
    res.qrc
