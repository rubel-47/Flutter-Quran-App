const BASE_URL = 'http://139.180.156.187:92/api/quran/';
const API_KEY = 'x-api-key';
const API_SECRET = '3R5TWxA0GAn04EQ42haCnYtFxeRlV08yMi5o';

const SHOP_URL = 'https://www.shop.qrfbd.org';
const SITE_URL = 'https://www.qrfbd.org';
var BUY_NOW_URL = '';
var LIBRARY_URL = 'https://student.qrfbd.org';
/*Api midpoints*/
const endpoint_surah_list = 'sura';
const endpoint_ayat = 'sura/ayats?sura_id=';
const endpoint_hadis = 'hadiss';
const endpoint_hadis_details = 'hadis/byid?hadis_id=';
const endpoint_research_paper = 'research/paper';
const endpoint_research_paper_details =
    'research/paper/byid?research_paper_id=';
const endpoint_lecture = 'lecture';
const endpoint_lecture_details = 'lecture/byid?lecture_id=';
const endpoint_ayat_search = 'ayat/search?keyword=';
const endpoint_hadis_search = 'hadis/search?keyword=';
const endpoint_research_paper_search_keyword = 'research/search?keyword=';
const endpoint_research_paper_search_tag = 'research/search/tagid?tag_id=';
const endpoint_lecture_search_keyword = 'lecture/search?keyword=';
const endpoint_lecture_search_category =
    'lecture/search/category/tag?category_id=';
const endpoint_lecture_search_tag = 'lecture/search/category/tag?tag_id=';
const endpoint_category = 'category/dropdown';
const endpoint_tag = 'tag/dropdown';
const endpoint_pages = 'pages';
const endpoint_pages_details = 'page/byid?page_id=';
const endpoint_signup = 'sign/up';
const endpoint_signin = 'sign/in';
const endpoint_create_bookmark = 'bookmark';
const endpoint_get_bookmark = 'bookmark/userid';
const endpoint_delete_bookmark_note = 'bookmark/delete?id=';
const endpoint_qrftv = 'qrftv';
const endpoint_qrftv_details = 'qrftv/byid?video_id=';
const endpoint_qrftv_category = 'qrftv/search/category/tag?category_id=';
const endpoint_qrftv_tag = 'qrftv/search/category/tag?tag_id=';
const endpoint_qrftv_search = 'qrftv/search?keyword=';

const bool hideHeader = false;
const bool hideFooter = false;

/*Sharedpreferences keys*/
const PREFS_ISLOGIN = 'isLogin';
const PREFS_USERID = 'userid';
const PREFS_NAME = 'name';
const PREFS_EMAIL = 'email';
const PREFS_MOBILE = 'mobile';
const PREFS_ADDRESS = 'address';

class ApiConstants {
  static String audio_base_url = 'http://139.180.156.187:92';
}
