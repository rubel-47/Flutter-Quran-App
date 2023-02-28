import 'package:get/get.dart';
import 'package:qrf/bindings/ayat_binding.dart';
import 'package:qrf/bindings/ayat_search_bindings.dart';
import 'package:qrf/bindings/bookmark_binding.dart';
import 'package:qrf/bindings/hadis_binding.dart';
import 'package:qrf/bindings/hadis_details_binding.dart';
import 'package:qrf/bindings/hadis_search_binding.dart';
import 'package:qrf/bindings/hadis_type_binding.dart';
import 'package:qrf/bindings/home_binding.dart';
import 'package:qrf/bindings/lecture_binding.dart';
import 'package:qrf/bindings/lecture_details_binding.dart';
import 'package:qrf/bindings/login_binding.dart';
import 'package:qrf/bindings/navigation_content_binding.dart';
import 'package:qrf/bindings/notes_binding.dart';
import 'package:qrf/bindings/paper_binding.dart';
import 'package:qrf/bindings/paper_details_binding.dart';
import 'package:qrf/bindings/qrftv_binding.dart';
import 'package:qrf/bindings/qrftv_category_binding.dart';
import 'package:qrf/bindings/signup_binding.dart';
import 'package:qrf/bindings/splash_binding.dart';
import 'package:qrf/bindings/surah_binding.dart';
import 'package:qrf/bindings/video_player_binding.dart';
import 'package:qrf/bindings/webview_binding.dart';
import 'package:qrf/screens/bookmark/bookmark_screen.dart';
import 'package:qrf/screens/hadis/hadis_details_screen.dart';
import 'package:qrf/screens/hadis/hadis_screen.dart';
import 'package:qrf/screens/hadis/hadis_search_screen.dart';
import 'package:qrf/screens/hadis/hadis_type_screen.dart';
import 'package:qrf/screens/home/home_screen.dart';
import 'package:qrf/screens/home/navigation_content_screen.dart';
import 'package:qrf/screens/home/notes_screen.dart';
import 'package:qrf/screens/lecture/lecture_details_screen.dart';
import 'package:qrf/screens/lecture/lecture_screen.dart';
import 'package:qrf/screens/library/library_screen.dart';
import 'package:qrf/screens/paper/buy_now_screen.dart';
import 'package:qrf/screens/paper/research_paper_details_screen.dart';
import 'package:qrf/screens/paper/research_paper_screen.dart';
import 'package:qrf/screens/qrftv/qrftv_category_screen.dart';
import 'package:qrf/screens/qrftv/qrftv_screen.dart';
import 'package:qrf/screens/qrftv/video_play_screen.dart';
import 'package:qrf/screens/quran/ayat_screen.dart';
import 'package:qrf/screens/quran/ayat_search_screen.dart';
import 'package:qrf/screens/quran/surah_screen.dart';

import 'package:qrf/screens/splash.dart';
import 'package:qrf/screens/user/login_screen.dart';
import 'package:qrf/screens/user/signup_screen.dart';
import 'package:qrf/screens/webview/webview_screen.dart';

import '../bindings/test_binding.dart';
import '../model/quran/surah_list.dart';
import '../screens/hadis/hadis_details_screen_offline.dart';
import '../screens/quran/single_ayat_screen_offline.dart';

class AppPages {
  static String INITIAL = '/splash';
  static String HOME = '/home';
  static String TEST= '/test';
  static String SURAH = '/surah';
  static String AYAT = '/ayat';
  static String HADIS = '/hadis';
  static String HADIS_DETAILS = '/hadisDetails';
  static String HADIS_DETAILS_OFFLINE='/hadisDetailsOffline';
  static String WEBVIEW = '/webview';
  static String HADIS_TYPE = '/hadisType';
  static String PAPER = '/paper';
  static String PAPER_DETAILS = '/paperDetails';
  static String LECTURE = '/lecture';
  static String LECTURE_DETAILS = '/lectureDetails';
  static String BUY_NOW = '/buyNow';
  static String AYAT_SEARCH = '/ayatSearch';
  static String HADIS_SEARCH = '/hadisSearch';
  static String NAVIGATION_CONTENT = '/navigationContent';
  static String SIGNUP = '/signup';
  static String LOGIN = '/login';
  static String BOOKMARK = '/bookmark';
  /* static String NOTES = '/notes'; */
  static String QRFTV = '/qrftv';
  static String QRF_CAT_TV = '/qrfCatTv';
  static String LIBRARY = '/library';
  static String VIDEO_PLAYER = '/video_player';

  static String getHomeRoute() => HOME;
  static String getTestRoute()=> TEST;
  static String getSurahRoute() => SURAH;
  static String getAyatRoute() => AYAT;
  static String getHadisRoute() => HADIS;
  static String getHadisTypeRoute() => HADIS_TYPE;
  static String getHadisDetailsRoute() => HADIS_DETAILS;
  static String getHadisDetailsRouteOffline()=> HADIS_DETAILS_OFFLINE;

  static String getPaperRoute() => PAPER;
  static String getPaperDetailsRoute() => PAPER_DETAILS;
  static String getLectureRoute() => LECTURE;
  static String getLectureDetailsRoute() => LECTURE_DETAILS;
  static String getBuyNowRoute() => BUY_NOW;
  static String getAyatSearchRoute() => AYAT_SEARCH;
  static String getHadisSearchRoute() => HADIS_SEARCH;
  static String getNavigationContentRoute() => NAVIGATION_CONTENT;
  static String getSignupRoute() => SIGNUP;
  static String getLoginRoute() => LOGIN;
  static String getBookmarkRoute() => BOOKMARK;
  /* static String getNotesRoute() => NOTES; */
  static String getQrftvRoute() => QRFTV;
  static String getQrftvCatRoute() => QRF_CAT_TV;
  static String getLibraryRoute() => LIBRARY;
  static String getVideoPlayerRoute() => VIDEO_PLAYER;

  static final routes = [
    GetPage(
        name: INITIAL, page: () => SplashScreen(), binding: SplashBinding()),
    GetPage(
        name: TEST,
        page: () => TestScreen(surahDetails:new Surah()),
        binding: TestBinding()
  ),
    GetPage(name: HOME, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(name: SURAH, page: () => SurahScreen(), binding: SurahBinding()),
    GetPage(name: AYAT, page: () => AyatScreen(), binding: AyatBinding()),
    GetPage(
        name: HADIS_TYPE,
        page: () => HadisTypeScreen(),
        binding: HadisTypeBinding()),
    GetPage(name: HADIS, page: () => HadisScreen(), binding: HadisBinding()),
    GetPage(
        name: HADIS_DETAILS,
        page: () => HadisDetailsScreen(),
        binding: HadisDetailsBinding()),


    GetPage(
        name: WEBVIEW, page: () => WebViewScreen(), binding: WebviewBinding()),
    GetPage(name: PAPER, page: () => PaperScreen(), binding: PaperBinding()),
    GetPage(
        name: PAPER_DETAILS,
        page: () => PaperDetailsScreen(),
        binding: PaperDetailsBinding()),
    GetPage(
        name: LECTURE, page: () => LectureScreen(), binding: LectureBinding()),
    GetPage(
        name: LECTURE_DETAILS,
        page: () => LectureDetailsScreen(),
        binding: LectureDetailsBinding()),
    GetPage(name: BUY_NOW, page: () => BuyNowScreen()),
    GetPage(
        name: AYAT_SEARCH,
        page: () => AyatSearchScreen(),
        binding: AyatSearchBinding()),
    GetPage(
        name: HADIS_SEARCH,
        page: () => HadisSearchScreen(),
        binding: HadisSearchBinding()),
    GetPage(
        name: NAVIGATION_CONTENT,
        page: () => NavigationContentScreen(),
        binding: NavigationContentBinding()),
    GetPage(name: SIGNUP, page: () => SignupScreen(), binding: SignupBinding()),
    GetPage(name: LOGIN, page: () => LoginScreen(), binding: LoginBinding()),
    GetPage(
        name: BOOKMARK,
        page: () => BookmarkScreen(),
        binding: BookmarkBinding()),
    /* GetPage(name: NOTES, page: () => NoteScreen(), binding: NotesBinding()), */
    GetPage(name: QRFTV, page: () => QrftvScreen(), binding: QrftvBinding()),
    GetPage(name: QRF_CAT_TV, page: () => QrftvCategoryScreen(), binding: QrftvCatBinding()),
    GetPage(name: LIBRARY, page: () => LibraryScreen()),
    GetPage(
        name: VIDEO_PLAYER,
        page: () => VideoPlayerScreen(),
        binding: VideoPlayerBinding()),
  ];
}
