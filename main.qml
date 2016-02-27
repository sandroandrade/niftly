import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.XmlListModel 2.0

import Material 0.2
import Material.ListItems 0.1 as ListItem

ApplicationWindow {
    title: "Niftly"
    width: 640
    height: 480
    visible: true

    theme {
        primaryColor: Palette.colors["blue"]["500"]
        accentColor: Palette.colors["blue"]["900"]
        tabHighlightColor: Palette.colors["blue"]["900"]
    }

    property var feeds: [
        { name: "Planet KDE", feed: "https://planetkde.org/rss20.xml", icon: "awesome/rss" },
        { name: "Planet Qt", feed: "http://planet.qt.io/rss20.xml", icon: "awesome/rss" },
    ]

    property var selectedFeed: feeds[0]

    XmlListModel {
        id: feedModel

        source: selectedFeed.feed
        query: "/rss/channel/item"

        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "author"; query: "author/string()" }
        XmlRole { name: "description"; query: "description/string()" }
    }

    initialPage: page

    Page {
        title: "Niftly"

        id: page

        actions: [
            Action {
                name: "Notifications"
                iconName: "social/notifications_active"
            }
        ]
        backAction: navDrawer.action
        NavigationDrawer {
            id: navDrawer
            enabled: true
            width: Units.dp(275)

            Flickable {
                anchors.fill: parent
                contentHeight: Math.max(content.implicitHeight, height)
                Column {
                    id: content
                    anchors.fill: parent
                    Repeater {
                        model: feeds
                        ListItem.Standard {
                            text: modelData.name
                            iconName: modelData.icon
                            selected: (selectedFeed !== undefined) ? (selectedFeed.name === text):false
                            onClicked: {
                                selectedFeed = modelData
                                navDrawer.close()
                            }
                        }
                    }
                }
            }
        }
        Item {
            anchors.fill: parent

            Flickable {
                id: flickable
                anchors.fill: parent
                clip: true
                contentHeight: Math.max(rssContent.implicitHeight + 40, height)
                Column {
                    id: rssContent
                    anchors.fill: parent
                    Repeater {
                        model: feedModel
                        ListItem.Subtitled {
                            text: title
                            subText: author
                            iconName: "awesome/rss"
                        }
                    }
                }
                ProgressCircle {
                    anchors.centerIn: parent
                    visible: feedModel.status !== XmlListModel.Ready
                }
            }
            Scrollbar {
                flickableItem: flickable
            }
        }
    }
}
