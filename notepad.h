#ifndef NOTEPAD_H
#define NOTEPAD_H

#include <QObject>
#include <QFile>
#include <QFileInfo>
#include <QUrl>
#include <QTimer>
class Notepad : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString date READ date WRITE setDate NOTIFY dateChanged)
public:
    explicit Notepad(QObject *parent = 0);


    // Setter
    void setDate(const QString& text);

    // Getter
    QString date() const;

 public slots:
    void save(const QString& data, const QUrl& url);
    QString open(const QUrl& url);


protected slots:
    void dateRefresh();



signals:
    void dateChanged();

private:
    QFile mFile;
    QString mDate;
    QTimer  mTimer;
};

#endif // NOTEPAD_H
