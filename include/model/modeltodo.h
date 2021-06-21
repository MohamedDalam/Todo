#ifndef MODELTODO_H
#define MODELTODO_H

#include <QAbstractListModel>
#include <QVector>
#include <QHash>
#include <QMap>

struct Record{
    Record(){};
    Record(bool active, QString description) :
        active(active), description(description) {};

    bool active;
    QString description;
};

class ModelTodo : public QAbstractListModel
{
    Q_OBJECT
public:
    enum RoleNames {
        Active = Qt::UserRole,
        Description
    };

    explicit ModelTodo(QObject *parent = nullptr);
    ~ModelTodo();

    Q_PROPERTY(int count READ count NOTIFY countChanged)
    Q_INVOKABLE void append(const bool active, const QString& description);
    Q_INVOKABLE void remove(int indexKey);
    Q_INVOKABLE void changeActiveState(int index);
    Q_INVOKABLE void swap(int firstKey, int secendKey);

    virtual int rowCount(const QModelIndex &parent) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    int count() const;

signals:
    void countChanged();

private:
    QVector<Record> modelData;
    QHash<int, QByteArray> modelRoleNames;
};

#endif // MODELTODO_H
