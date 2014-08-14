#include "notepad.h"
#include <QDebug>
#include <QFile>
#include <QTextStream>
#include <QDateTime>

Notepad::Notepad(QObject *parent) :
    QObject(parent)
{

    mTimer.setInterval(1000);
    connect(&mTimer,SIGNAL(timeout()),this,SLOT(dateRefresh()));
    mTimer.start();

}

void Notepad::setDate(const QString &text)
{
    mDate = text;
    emit dateChanged();

}

QString Notepad::date() const
{
    return mDate;
}

void Notepad::save(const QString &data, const QUrl &url)
{

    mFile.setFileName(url.toLocalFile());
    mFile.open(QIODevice::WriteOnly|QIODevice::Text);
    QTextStream out(&mFile);
    out<<data;
    mFile.close();

}

QString Notepad::open(const QUrl &url)
{

    mFile.setFileName(url.toLocalFile());
    mFile.open(QIODevice::ReadOnly|QIODevice::Text);
    QString text = mFile.readAll();
    mFile.close();

    return text;



}

void Notepad::dateRefresh()
{

    QString date = QDateTime::currentDateTime().toString("ddd MMM yyyy hh:mm:ss");
    setDate(date);

}
