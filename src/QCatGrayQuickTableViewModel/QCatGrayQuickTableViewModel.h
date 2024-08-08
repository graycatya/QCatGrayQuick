#pragma once


#include <QAbstractListModel>
#include "QCatGrayQuickTableViewModelStruct.h"
#include "QCatGrayQuickTableViewHeaderStruct.h"

class QCatGrayQuickTableViewModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QList<QSharedPointer<QCatGrayQuickTableViewModelStruct>> tabledata READ tabledata  NOTIFY tabledataChanged)
    Q_PROPERTY(uint headerCount READ headerCount WRITE setHeaderCount NOTIFY headerCountChanged)
    Q_PROPERTY(int preferredHeaderHeight READ preferredHeaderHeight WRITE setPreferredHeaderHeight NOTIFY preferredHeaderHeightChanged)
    Q_PROPERTY(int minimumHeaderHeight READ minimumHeaderHeight WRITE setMinimumHeaderHeight NOTIFY minimumHeaderHeightChanged)
    Q_PROPERTY(int maximumHeaderHeight READ maximumHeaderHeight WRITE setMaximumHeaderHeight NOTIFY maximumHeaderHeightChanged)
    Q_PROPERTY(int flickableWidth READ flickableWidth WRITE setFlickableWidth NOTIFY flickableWidthChanged)
public:
    explicit QCatGrayQuickTableViewModel(QObject *parent = nullptr);
    ~QCatGrayQuickTableViewModel();
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE QCatGrayQuickTableViewModelStruct* appendStruct(QJsonObject object);
    Q_INVOKABLE QCatGrayQuickTableViewModelStruct* getStruct(int index);
    Q_INVOKABLE int getStructSize();

    Q_INVOKABLE void removeStruct(int index);
    Q_INVOKABLE void clearModel();

    int headerCount() const { return m_HeaderCount; }
    Q_INVOKABLE void setHeaderCount(int headerCount);
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

    Q_INVOKABLE void updateHeaderStruct();

    Q_INVOKABLE QList<QSharedPointer<QCatGrayQuickTableViewModelStruct>> tabledata() const { return m_StructList; }

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


private:
    QList<QSharedPointer<QCatGrayQuickTableViewModelStruct>> m_StructList;
    QList<QSharedPointer<QCatGrayQuickTableViewHeaderStruct>> m_headerStruct;
    uint m_HeaderCount = 0;
    int m_PreferredHeaderHeight = 30;
    int m_MinimumHeaderHeight = 30;
    int m_MaximumHeaderHeight = 30;
    int m_FlickableWidth = 0;
};
