/* sradhakrishnan
 * Sunday, October 13, 2013.
 */

#include <bb/cascades/AbstractPane>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>

#include <QLocale>
#include <QTranslator>

using namespace bb::cascades;

/*
 * Legal Information for podcast used
 *
 * Podcast UrL: http://feedproxy.google.com/~r/MotleyFoolMoney/~5/tU4mIwXmpSk/02_25_2011_Motley_Fool_Money.mp3
 * Source : Apple iTunes
 */
Q_DECL_EXPORT int main(int argc, char **argv)
{
    Application app(argc, argv);

    // localization support
    QTranslator translator;
    QString locale_string = QLocale().name();
    QString filename = QString( "m_podcast_player_%1" ).arg( locale_string );
    if (translator.load(filename, "app/native/qm")) {
        app.installTranslator( &translator );
    }

    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(&app);
    AbstractPane *root = qml->createRootObject<AbstractPane>();
    app.setScene(root);

    return Application::exec();
}
