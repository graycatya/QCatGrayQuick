#pragma once


#include <QAbstractListModel>
#include "QCatGrayQuickTableViewModelStruct.h"
#include "QCatGrayQuickTableViewHeaderStruct.h"

class QCatGrayQuickTableViewModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QList<QSharedPointer<QCatGrayQuickTableViewModelStruct>> tabledata READ tabledata  NOTIFY tabledataChanged)
    Q_PROPERTY(QStringList headerTableData READ headerTableData WRITE setHeaderTableData NOTIFY headerTableDataChanged)
    Q_PROPERTY(int preferredHeaderHeight READ preferredHeaderHeight WRITE setPreferredHeaderHeight NOTIFY preferredHeaderHeightChanged)
    Q_PROPERTY(int minimumHeaderHeight READ minimumHeaderHeight WRITE setMinimumHeaderHeight NOTIFY minimumHeaderHeightChanged)
    Q_PROPERTY(int maximumHeaderHeight READ maximumHeaderHeight WRITE setMaximumHeaderHeight NOTIFY maximumHeaderHeightChanged)
    Q_PROPERTY(int preferredItemHeight READ preferredItemHeight WRITE setPreferredItemHeight NOTIFY preferredItemHeightChanged)
    Q_PROPERTY(int minimumItemHeight READ minimumItemHeight WRITE setMinimumItemHeight NOTIFY minimumItemHeightChanged)
    Q_PROPERTY(int maximumItemHeight READ maximumItemHeight WRITE setMaximumItemHeight NOTIFY maximumItemHeightChanged)
    Q_PROPERTY(int flickableWidth READ flickableWidth WRITE setFlickableWidth NOTIFY flickableWidthChanged)
    Q_PROPERTY(bool interactive READ interactive WRITE setInteractive NOTIFY interactiveChanged)
public:
    explicit QCatGrayQuickTableViewModel(QObject *parent = nullptr);
    ~QCatGrayQuickTableViewModel();
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE QCatGrayQuickTableViewModelStruct* appendStruct(QJsonObject object);
    Q_INVOKABLE QCatGrayQuickTableViewModelStruct* appendStructObject(QObject* object);
    Q_INVOKABLE void updateStruct(int index, QJsonObject object);
    Q_INVOKABLE QCatGrayQuickTableViewModelStruct* getStruct(int index);
    Q_INVOKABLE int getStructSize();

    Q_INVOKABLE void removeStruct(int index);
    Q_INVOKABLE void clearModel();

    Q_INVOKABLE QCatGrayQuickTableViewHeaderStruct* getHeaderStruct(int index);

    Q_INVOKABLE void setAllHeaderPreferredWidth(int width);
    Q_INVOKABLE void setAllHeaderMinimumWidth(int width);
    Q_INVOKABLE void setAllHeaderMaximumWidth(int width);

    Q_INVOKABLE void setAllItemPreferredHeight(int height);
    Q_INVOKABLE void setAllItemMinimumHeight(int height);
    Q_INVOKABLE void setAllItemMaximumHeight(int height);

    int preferredHeaderHeight() const { return m_PreferredHeaderHeight; }
    void setPreferredHeaderHeight(int height);

    int minimumHeaderHeight() const { return m_MinimumHeaderHeight; }
    void setMinimumHeaderHeight(int height);

    int maximumHeaderHeight() const { return m_MaximumHeaderHeight; }
    void setMaximumHeaderHeight(int height);

    int flickableWidth() const { return m_FlickableWidth; }
    Q_INVOKABLE void setFlickableWidth(int width);

    Q_INVOKABLE void setOverrideCursor(Qt::CursorShape shape);

    Q_INVOKABLE void restoreOverrideCursor();

    Q_INVOKABLE void updateHeaderStruct();

    Q_INVOKABLE QList<QSharedPointer<QCatGrayQuickTableViewModelStruct>> tabledata() const { return m_StructList; }

    Q_INVOKABLE QStringList headerTableData() const { return m_headerTableData; }
    Q_INVOKABLE void setHeaderTableData(QStringList data);

    Q_INVOKABLE bool interactive() const { return m_Interactive; }
    Q_INVOKABLE void setInteractive(bool interactive);

    Q_INVOKABLE void setPreferredItemHeight(int height);
    Q_INVOKABLE void setMinimumItemHeight(int height);
    Q_INVOKABLE void setMaximumItemHeight(int height);

    int preferredItemHeight() const {
        return m_PreferredItemHeight;
    }

    int minimumItemHeight() const {
        return m_MinimumItemHeight;
    }

    int maximumItemHeight() const {
        return m_MaximumItemHeight;
    }

private:
    void InitConnect();

signals:
    void headerCountChanged();
    void preferredHeaderHeightChanged();
    void minimumHeaderHeightChanged();
    void maximumHeaderHeightChanged();

    void setAllHeaderPreferredWidthed(int width);
    void setAllHeaderMinimumWidthed(int width);
    void setAllHeaderMaximumWidthed(int width);

    void setAllItemPreferredHeighted(int height);
    void setAllItemMinimumHeighted(int height);
    void setAllItemMaximumHeighted(int height);

    void flickableWidthChanged();

    void tabledataChanged();

    void headerTableDataChanged();

    void interactiveChanged();

    void preferredItemHeightChanged();
    void minimumItemHeightChanged();
    void maximumItemHeightChanged();

private:
    QList<QSharedPointer<QCatGrayQuickTableViewModelStruct>> m_StructList;
    QList<QSharedPointer<QCatGrayQuickTableViewHeaderStruct>> m_headerStruct;
    QStringList m_headerTableData;
    int m_PreferredHeaderHeight = 30;
    int m_MinimumHeaderHeight = 30;
    int m_MaximumHeaderHeight = 30;
    int m_PreferredItemHeight = 30;
    int m_MinimumItemHeight = 30;
    int m_MaximumItemHeight = 30;
    int m_FlickableWidth = 0;
    bool m_Interactive = true;
};
