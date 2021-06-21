#include "include/model/modeltodo.h"

ModelTodo::ModelTodo(QObject *parent):
    QAbstractListModel(parent)
{
    modelRoleNames[Active] = "active";
    modelRoleNames[Description] = "description";
}

ModelTodo::~ModelTodo()
{
}

void ModelTodo::append(const bool active, const QString &description)
{
    if(description == "") return;
    const int row = rowCount(QModelIndex());
    beginInsertRows(QModelIndex(),row,row);
    modelData.push_back(Record(active,description));
    endInsertRows();
    emit countChanged();
}

void ModelTodo::remove(int indexKey)
{
    if (indexKey < 0 || indexKey > modelData.count())
        return;

    beginRemoveRows(QModelIndex(), indexKey, indexKey);
    modelData.removeAt(indexKey);
    endRemoveRows();
    emit countChanged();
}

void ModelTodo::changeActiveState(int index)
{
    if (index < 0 || index >= modelData.count())
        return;
    modelData[index].active = !modelData[index].active;
}

void ModelTodo::swap(int firstKey, int secendKey)
{
    if(firstKey == secendKey) return;
    // Check to be safe
    auto temp = modelData.at(firstKey);
    modelData[firstKey] = modelData[secendKey];
    modelData[secendKey] = temp;
    QModelIndex topLeft = createIndex(0,0);
    QModelIndex bottomRight = createIndex(modelData.count(),0);
    emit dataChanged(topLeft,bottomRight);
}

int ModelTodo::rowCount(const QModelIndex &parent) const
{
    return modelData.count();
}

QVariant ModelTodo::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if(row < 0 || row >= modelData.count()) {
        return QVariant();
    }
    const Record& record = modelData[row];
    switch(role) {
    case Active:
        return record.active;
    case Description:
        return record.description;
    }
    return QVariant();
}

QHash<int, QByteArray> ModelTodo::roleNames() const
{
    return modelRoleNames;
}


int ModelTodo::count() const
{
    return rowCount(QModelIndex());
}
