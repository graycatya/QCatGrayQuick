#pragma once

#include <QObject>

class QCatGrayQuickTableViewHeaderStruct : public QObject
{
    Q_OBJECT
    Q_PROPERTY(ResizeMode resizeMode READ resizeMode WRITE setResizeMode NOTIFY resizeModeChanged)
    Q_PROPERTY(int preferredWidth READ preferredWidth WRITE setPreferredWidth NOTIFY preferredWidthChanged)
    Q_PROPERTY(int minimumWidth READ minimumWidth WRITE setMinimumWidth NOTIFY minimumWidthChanged)
    Q_PROPERTY(int maximumWidth READ maximumWidth WRITE setMaximumWidth NOTIFY maximumWidthChanged)
    Q_ENUMS(ResizeMode)
public:
    enum ResizeMode {
        Fixed,  // The user cannot resize the section.
        FixedCanBeManuallyAdjusted, // Fixed can be manually adjusted
        Stretch,    // automatically resize the section to fill the available space.
        ResizeToContents    // automatically resize the section to its optimal width based on the contents of the entire column or row.
    };

    explicit QCatGrayQuickTableViewHeaderStruct(QObject *parent = nullptr);
    ~QCatGrayQuickTableViewHeaderStruct() override;

    ResizeMode resizeMode() const { return m_ResizeMode; }
    void setResizeMode(ResizeMode mode);

    int preferredWidth() const { return m_PreferredWidth; }
    void setPreferredWidth(int width);

    int minimumWidth() const { return m_MinimumWidth; }
    void setMinimumWidth(int width);


    int maximumWidth() const { return m_MaximumWidth; }
    void setMaximumWidth(int width);

signals:
    void resizeModeChanged();
    void preferredWidthChanged();
    void minimumWidthChanged();
    void maximumWidthChanged();

private:
    int m_PreferredWidth = 50;
    int m_MinimumWidth = 50;
    int m_MaximumWidth = 50;
    ResizeMode m_ResizeMode = Fixed;


};

