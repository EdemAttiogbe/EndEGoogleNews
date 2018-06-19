//
//  EndEGoogleNews.swift
//
//  Created by Edem Attiogbe Cylindrical Mac Pro on 9/22/17.
//  Copyright © 2017 EndE Group. All rights reserved.
//
//  EndEGoogleNews is based of off the rough, unofficial Google News Feed RSS API specs documented by James McKinney in his Google News Search parameters (The Missing Manual): http://web.archive.org/web/20150204025359/http://blog.slashpoundbang.com/post/12975232033/google-news-search-parameters-the-missing-manual
//  EndEGoogleNews is meant to support RSS or ATOM output formats
//  Google News parameters types (from The Missing Manual link above) currently not supported: Boost, Tracking, Search, Undocumented, Deprecated

import Foundation

public struct EndEGoogleSearchParameters{//Represents any and all search parameters that are applicable to a Google News Feed, for the request
    
    fileprivate enum  SearchParameters{//Represents the actual parameter name in the URL string for Google News Feeds.  **Note that this is only used by EndEGoogleNewsManager below, as there is only one option ('Terms'), thus, no need for the API user to do anything
        case Terms;//Define a value representing the search terms parameter
        
        fileprivate var searchParam: String{//Reprsents the actual parameter name to return
            
            switch self {
            case .Terms:
                return("q=");//Return 'q', the name of the search terms parameter for Google News Feeds
            default:
                return("");
            }
        }
    }
    
    //**Note, the below 'searchTerms' and corresponding mutating functions don't have to be used
    var searchTerms: [String] = [String]();//Search Terms for the Google News Feed request
    
    mutating func changeTerms(newTerms: [String]){//Change a term already in the term list
        self.searchTerms = newTerms;
    }
    
    mutating func addTerms(newTerm: String){//Add a new term to the parameter list
        self.searchTerms.append(newTerm);
    }
    
    mutating func removeTerm(termToRemove: String){//Remove a specific term form the term list
        let terPosition: Int? = self.searchTerms.index(of: termToRemove);
        if(terPosition != nil){
            self.searchTerms.remove(at: terPosition!);
        }
    }
    
    mutating func removeAllTerms(){//Remove all terms
        self.searchTerms.removeAll();
    }
}

public struct EndEGoogleFilterParameters{//Represents any and all filter parameters that are applicable to a Google news Feed, for the request
    
    enum FilterParameters{//All available Google News Filter parameters
        
        case ArticleAtSpecificTime;//Articles at a specific time
        enum SpecificTimeVals{
            case Anytime;//Anytime
            case LastHour;//LastHour
            case LastDay;//LastDay
            case PastWeek;//PastWeek
            case PastMonth;//PastMonth
            case PastYear;//PastYear
            
           fileprivate var filterBySpecificTimeOptions: String{//Limit the results to articles obtained from a specific specified time
                switch self{
                case .Anytime:
                    return("as_qdr=a");
                case .LastHour:
                    return("as_qdr=h");
                case .LastDay:
                    return("as_qdr=d");
                case .PastWeek:
                    return("as_qdr=w");
                case .PastMonth:
                    return("as_qdr=m");
                case .PastYear:
                    return("as_qdr=y");
                default:
                    return("");
                }
            }
        }
        
        case ArticleBetweenSpecificTimes;//Articles between a specific time
        enum BetweenSpecificTimes{
            case MinMonth;//Minimum Month
            case MinDay;//Minimum Day
            case MaxMonth;//Maximum Month
            case MaxDay;//Maximum Day
            
           fileprivate var filterBetweenSpecificTimes: String{//Limit the results to articles obtained between specific specified times
                switch self{
                case .MinMonth:
                    return("as_minm=");
                case .MinDay:
                    return("as_mind=");
                case .MaxMonth:
                    return("as_maxm=");
                case .MaxDay:
                    return("as_maxd=");
                default:
                    return("");
                }
            }
        }
        
        case ArticleLocation;//Article results at a specific location
        enum FilterLocation{
            case DetectMacroArea;//Tells Google News to detect the requester's location based on his/her IP
            
           fileprivate var filterLocationOptions: String{//Limit the results to a specific location (can be a city, state, zip code(USA), country, or auto-detected (with 'detect macro area'))
                switch self{
                case .DetectMacroArea:
                    return("detect_metro_area");
                default:
                    return("");
                }
            }
        }
        
        case ArticleTopic;//Article results of a specific topic
        
        case ArticleEdition;//Article results of a specific edition
        enum Edition{//Refer to this google support document for a list of all editions: https://support.google.com/news/publisher/answer/40237?hl=en
            
            //Asia Territories
            case Arab_World;
            case Australian_English;
            case Bangladesh;
            case China;
            case Hong_Kong;
            case India_English;
            case India_Hindi;
            case India_Malayalam;
            case India_Tamil;
            case India_Telugu;
            case Indonesia;
            case Israel_English;
            case Israel_Hebrew;
            case Japan;
            case Lebanon;
            case Malaysia;
            case New_Zealand;
            case Pakistan;
            case Philippines;
            case Saudi_Arabia;
            case Singapore;
            case South_Korea;
            case Taiwan;
            case Thailand;
            case UAE;
            case Vietnam;
            
            //Africa & Europe Territories:
            case Austria;
            case Belgium_Dutch;
            case Belgium_French;
            case Botswana;
            case Bulgaria;
            case Czech_Republic;
            case Egypt;
            case Ethiopia;
            case France;
            case Germany;
            case Ghana;
            case Greece;
            case Hungary;
            case Ireland;
            case Italy;
            case Kenya;
            case Latvia;
            case Lithuania;
            case Morocco;
            case Namibia;
            case Netherlands;
            case Nigeria;
            case Norway;
            case Poland;
            case Portugal;
            case Romania;
            case Russia;
            case Senegal;
            case Serbia;
            case Slovenia;
            case Slovakia;
            case South_Africa;
            case Sweden;
            case Switzerland_French;
            case Switzerland_German;
            case Tanzania;
            case Turkey;
            case Uganda;
            case Ukraine_Russian;
            case Ukraine_Ukranian;
            case United_Kingdom;
            case Zimbabwe;
            
            //North & South America
            case Argentina;
            case Brazil;
            case Canada_English;
            case Canada_French;
            case Chile;
            case Colombia;
            case Cuba;
            case Mexico;
            case Peru;
            case United_States_English;
            case United_States_Spanish;
            case Venezuela;
            
            fileprivate var editionChoice: String{//The chosen edition
                switch self{
                case .Arab_World:
                    return("ar_me");
                case .Australian_English:
                    return("au");
                case .Bangladesh:
                    return("bn_bd");
                case .China:
                    return("cn");
                case .Hong_Kong:
                    return("hk");
                case .India_English:
                    return("in");
                case .India_Hindi:
                    return("hi_in");
                case .India_Malayalam:
                    return("ml_in");
                case .India_Tamil:
                    return("ta_in");
                case .India_Telugu:
                    return("te_in");
                case .Indonesia:
                    return("id_id");
                case .Israel_English:
                    return("en_il");
                case .Israel_Hebrew:
                    return("iw_il");
                case .Japan:
                    return("jp");
                case .Lebanon:
                    return("ar_lb");
                case .Malaysia:
                    return("en_my");
                case .New_Zealand:
                    return("nz");
                case .Pakistan:
                    return("en_pk");
                case .Philippines:
                    return("en_ph");
                case .Saudi_Arabia:
                    return("ar_sa");
                case .Singapore:
                    return("en_sg");
                case .South_Korea:
                    return("kr");
                case .Taiwan:
                    return("tw");
                case .Thailand:
                    return("th_th");
                case .UAE:
                    return("ar_ae");
                case .Vietnam:
                    return("vi");
                case .Austria:
                    return("de_at");
                case .Belgium_Dutch:
                    return("nl_be");
                case .Belgium_French:
                    return("fr_be");
                case .Botswana:
                    return("en_bw");
                case .Bulgaria:
                    return("bg_bg");
                case .Czech_Republic:
                    return("cs_cz");
                case .Egypt:
                    return("ar_eg");
                case .Ethiopia:
                    return("en_et");
                case .France:
                    return("fr");
                case .Germany:
                    return("de");
                case .Ghana:
                    return("en_gh");
                case .Greece:
                    return("el_gr");
                case .Hungary:
                    return("hu_hu");
                case .Ireland:
                    return("en_ie");
                case .Italy:
                    return("it");
                case .Kenya:
                    return("en_ke");
                case .Latvia:
                    return("lv_lv");
                case .Lithuania:
                    return("lt_lt");
                case .Morocco:
                    return("fr_ma");
                case .Namibia:
                    return("en_na");
                case .Netherlands:
                    return("nl_nl");
                case .Nigeria:
                    return("en_ng");
                case .Norway:
                    return("no_no");
                case .Poland:
                    return("pl_pl");
                case .Portugal:
                    return("pt-PT_pt");
                case .Romania:
                    return("ro_ro");
                case .Russia:
                    return("ru_ru");
                case .Senegal:
                    return("fr_sn");
                case .Serbia:
                    return("sr_rs");
                case .Slovakia:
                    return("sk_sk");
                case .Slovenia:
                    return("sl_si");
                case .South_Africa:
                    return("en_za");
                case .Sweden:
                    return("sv_se");
                case .Switzerland_French:
                    return("fr-CH");
                case .Switzerland_German:
                    return("de_ch");
                case .Tanzania:
                    return("en_tz");
                case .Turkey:
                    return("tr_tr");
                case .Uganda:
                    return("en_ug");
                case .Ukraine_Russian:
                    return("ru_ua");
                case .Ukraine_Ukranian:
                    return("uk_ua");
                case .United_Kingdom:
                    return("uk");
                case .Zimbabwe:
                    return("en_zw");
                case .Argentina:
                    return("es_ar");
                case .Brazil:
                    return("pt-BR_br");
                case .Canada_French:
                    return("fr_ca");
                case .Canada_English:
                    return("ca");
                case .Chile:
                    return("es_cl");
                case .Colombia:
                    return("es_co");
                case .Cuba:
                    return("es_cu");
                case .Mexico:
                    return("es_mx");
                case .Peru:
                    return("es_pe");
                case .United_States_English:
                    return("us");
                case .United_States_Spanish:
                    return("es_us");
                case .Venezuela:
                    return("es_ve");
                default:
                    return("");
                }
            }
        }
        
        case ArticleSource;//Article results of a specific source
        case ArticleSourceLocation;//Article results of a specific source location
        case ArticleAuthor;//Article results of a specific author
        
        fileprivate var filterParam: String{
            switch self{
            case .ArticleAtSpecificTime:
                return("as_drrb=q");
            case .ArticleBetweenSpecificTimes:
                return("as_drrb=b");
            case .ArticleLocation:
                return("geo=");
            case .ArticleTopic:
                return("topic=");
            case .ArticleEdition:
                return("ned=");
            case .ArticleSource:
                return("as_nsrc=");
            case .ArticleSourceLocation:
                return("as_nloc=");
            case .ArticleAuthor:
                return("as_author=");
            default:
                return("");
            }
        }
    }
    
    //Individual Filters.  These **Need** to be set according to the rules listed in the comments below for each filter
    //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    var filtEdition: FilterParameters.Edition? = nil;//Filter for setting the edition.  Needed if 'ArticleEdition' is chosen for the main 'FilterParameters'
    
    struct FiltBetweenTimesGroup{
        fileprivate var minimumDayOrMonth: String;//Filter value for either minimum day or month.  Needed if 'ArticleBetweenSpecificTimes' is chosen for the main 'FilterParameters'
        fileprivate var maximumDayOrMonth: String;//Filter value for either maximum day or month.  Needed if 'ArticleBetweenSpecificTimes' is chosen for the main 'FilterParameters'
    }
    var filtBetweenTimesParameters: FiltBetweenTimesGroup? = nil;//Filter group parameters for setting the time range between two chosen times. Needed if 'ArticleBetweenSpecificTimes' is chosen for the main 'FilterParameters'
    var filtBetweenTimesMinVal: FilterParameters.BetweenSpecificTimes? = nil;//Filter group for setting the time range between two chosen times. Needed if 'ArticleBetweenSpecificTimes' is chosen for the main 'FilterParameters'
    var filtBetweenTimesMaxVal: FilterParameters.BetweenSpecificTimes? = nil;//Filter group for setting the time range between two chosen times. Needed if 'ArticleBetweenSpecificTimes' is chosen for the main 'FilterParameters'
    
    var filtSpecificTime: FilterParameters.SpecificTimeVals? = nil;//Filter for setting specific time values.  Needed if 'ArticleAtSpecificTime' is chosen for the main 'FilterParameters'
    
    var filtLocation: FilterParameters.FilterLocation? = nil;//Filter for setting specific location values. Needed if 'ArticleLocation' is chosen for the main 'FilterParameters'
    
    var filtTopic: String? = nil;//The article topic.  Needed if 'ArticleTopic' is chosen for the main 'FilterParameters'
    
    var filtSource: String? = nil;//The article source.  Needed if 'ArticleSource' is chosen for the main 'FilterParameters'
    
    var filtSourceLocation: String? = nil;//The article source location.  Needed if 'ArticleSourceLocation' is chosen for the main 'FilterParameters'
    
    var filtAuthor: String? = nil;//The article author.  Needed if 'ArticleAuthor' is chosen for the main 'FilterParameters'
    
    var filtMain: [FilterParameters] = [FilterParameters]();//Main 'FilterParameters'.  Make sure to *NOT* specify both .ArticleAtSpecificTime & .ArticleBetweenSpecificTimes (either/or for these ones).  Apart from that, one can specify everything else
    
    //var filterValues: [String:FilterParameters]?;//Filters for Google News Feed request.  Dictionary maps 'String' value of filter to filter's corresponding parameter 'FilterParameters'.  Currently *NOT* used
}

/*extension EndEGoogleFilterParameters: Hashable{
    
    var hashValue: Int{
        var iterate: Int = 0;
        var finalHashVal: Int = 1;
        if(filterValues != nil){
            var allFilters: [FilterParameters] = Array(filterValues!.values);
            while( iterate < allFilters.count){
                let filter: FilterParameters = allFilters[iterate];
                finalHashVal = filter.hashValue ^ finalHashVal.hashValue;
                iterate += 1;
            }
        }
        return(finalHashVal);
    }
    
    static func == (lhs: EndEGoogleFilterParameters, rhs: EndEGoogleFilterParameters) -> Bool{//Needed because the Hashable protocol inherits from the Equatable protocol
        var areEqual: Bool = false;
        if((lhs.filterValues != nil) && (rhs.filterValues != nil)){
            areEqual = true;
        }
        return (areEqual);
    }
}*/

public struct EndEGoogleOrderParameters{//Represents any and all sort order parameters that are applicable to a Google News Feed, for the request
    
    enum OrderParameters{
        
        case Order;
        enum OrderChoices{
            case Relevance;//By relevance
            case N_Date;//By date (newest first)
            case N_D_Date;//By date (newest first with duplicates)
            case O_Date;//By date (oldest first)
            
            fileprivate var orderChoices: String{//Various choices for how to order the results
                switch self{
                case .Relevance:
                    return("r");
                case .N_Date:
                    return("n");
                case .N_D_Date:
                    return("d");
                case .O_Date:
                    return("o");
                default:
                    return("");
                }
            }
        }
        
        fileprivate var orderParam: String{
            switch self{
            case .Order:
                return("scoring=");
            default:
                return("");
            }
        }
    }
    
    fileprivate var oParam: OrderParameters = OrderParameters.Order;//No need for an API user to set this, as there is only one choice (Order). Only used by EndEGoogleNewsManager below
    var oChoice: OrderParameters.OrderChoices? = nil;//Specify how to order the returned results
}

public struct EndEGooglePaginationParameters{//Represents any and all pagination parameters that are applicable to a Google News Feed, for the request
    
    enum PaginationParameters{
        case NumberofPages;//Number of articles to returned.  Default is 10.  Valid range is 1-30
        
        fileprivate var paginationParameters: String{
            switch self{
            case .NumberofPages:
                return("num=");
            default:
                return("");
            }
        }
    }
    
    fileprivate var paginationParam: PaginationParameters = PaginationParameters.NumberofPages;//No need for an API user to set this, as there is only one choice (NumberofPages). Only used by EndEGoogleNewsManager below
    var paginationValue: Int = 30;//Pagination setting for the Google News Feed request.  API user will need to specify how many results can be returned (Valid range is 1-30)
}

public struct EndEGoogleOutputParameters{
    
    enum OutputParameters{
        
        case OutputFormat;
        enum Output{
            case RSS;
            case ATOM;
            
            fileprivate var outputFormat: String{
                switch  self {
                case .RSS:
                    return("rss");
                case .ATOM:
                    return("atom");
                default:
                    return("");
                }
            }
        }
        
        case HostLanguage;
        enum Language{//Refer to this google support document for a list of all languages: https://support.google.com/news/publisher/answer/40237?hl=en
            
            //Asia Territories
            case Arab_World;
            case Australian_English;
            case Bangladesh;
            case China;
            case Hong_Kong;
            case India_English;
            case India_Hindi;
            case India_Malayalam;
            case India_Tamil;
            case India_Telugu;
            case Indonesia;
            case Israel_English;
            case Israel_Hebrew;
            case Japan;
            case Lebanon;
            case Malaysia;
            case New_Zealand;
            case Pakistan;
            case Philippines;
            case Saudi_Arabia;
            case Singapore;
            case South_Korea;
            case Taiwan;
            case Thailand;
            case UAE;
            case Vietnam;
            
            //Africa & Europe Territories:
            case Austria;
            case Belgium_Dutch;
            case Belgium_French;
            case Botswana;
            case Bulgaria;
            case Czech_Republic;
            case Egypt;
            case Ethiopia;
            case France;
            case Germany;
            case Ghana;
            case Greece;
            case Hungary;
            case Ireland;
            case Italy;
            case Kenya;
            case Latvia;
            case Lithuania;
            case Morocco;
            case Namibia;
            case Netherlands;
            case Nigeria;
            case Norway;
            case Poland;
            case Portugal;
            case Romania;
            case Russia;
            case Senegal;
            case Serbia;
            case Slovenia;
            case Slovakia;
            case South_Africa;
            case Sweden;
            case Switzerland_French;
            case Switzerland_German;
            case Tanzania;
            case Turkey;
            case Uganda;
            case Ukraine_Russian;
            case Ukraine_Ukranian;
            case United_Kingdom;
            case Zimbabwe;
            
            //North & South America
            case Argentina;
            case Brazil;
            case Canada_English;
            case Canada_French;
            case Chile;
            case Colombia;
            case Cuba;
            case Mexico;
            case Peru;
            case United_States_English;
            case United_States_Spanish;
            case Venezuela;
            
            fileprivate var languageChoices: String{
                switch self {
                case .Arab_World:
                    return("ar");
                case .Australian_English:
                    return("en-AU");
                case .Bangladesh:
                    return("bn");
                case .China:
                    return("zh-CN");
                case .Hong_Kong:
                    return("zh-HK");
                case .India_English:
                    return("en-IN");
                case .India_Hindi:
                    return("hi");
                case .India_Malayalam:
                    return("ml");
                case .India_Tamil:
                    return("ta");
                case .India_Telugu:
                    return("te");
                case .Indonesia:
                    return("id");
                case .Israel_English:
                    return("en");
                case .Israel_Hebrew:
                    return("iw");
                case .Japan:
                    return("ja");
                case .Lebanon:
                    return("ar");
                case .Malaysia:
                    return("en-MY");
                case .New_Zealand:
                    return("en-NZ");
                case .Pakistan:
                    return("en");
                case .Philippines:
                    return("en");
                case .Saudi_Arabia:
                    return("ar");
                case .Singapore:
                    return("en-SG");
                case .South_Korea:
                    return("ko");
                case .Taiwan:
                    return("zh-TW");
                case .Thailand:
                    return("th");
                case .UAE:
                    return("ar");
                case .Vietnam:
                    return("vi");
                case .Austria:
                    return("de-AT");
                case .Belgium_Dutch:
                    return("nl");
                case .Belgium_French:
                    return("fr");
                case .Botswana:
                    return("en");
                case .Bulgaria:
                    return("bg");
                case .Czech_Republic:
                    return("cs");
                case .Egypt:
                    return("ar-EG");
                case .Ethiopia:
                    return("en");
                case .France:
                    return("fr");
                case .Germany:
                    return("de");
                case .Ghana:
                    return("en");
                case .Greece:
                    return("el");
                case .Hungary:
                    return("hu");
                case .Ireland:
                    return("en-IE");
                case .Italy:
                    return("it");
                case .Kenya:
                    return("en");
                case .Latvia:
                    return("lv");
                case .Lithuania:
                    return("lt");
                case .Morocco:
                    return("fr");
                case .Namibia:
                    return("en");
                case .Netherlands:
                    return("nl");
                case .Nigeria:
                    return("en");
                case .Norway:
                    return("no");
                case .Poland:
                    return("pl");
                case .Portugal:
                    return("pt-PT");
                case .Romania:
                    return("ro");
                case .Russia:
                    return("ru");
                case .Senegal:
                    return("fr");
                case .Serbia:
                    return("sr");
                case .Slovakia:
                    return("sk");
                case .Slovenia:
                    return("sl");
                case .South_Africa:
                    return("en");
                case .Sweden:
                    return("sv");
                case .Switzerland_French:
                    return("fr_ch");
                case .Switzerland_German:
                    return("de-CH");
                case .Tanzania:
                    return("en");
                case .Turkey:
                    return("tr");
                case .Uganda:
                    return("en");
                case .Ukraine_Russian:
                    return("ru");
                case .Ukraine_Ukranian:
                    return("uk");
                case .United_Kingdom:
                    return("en-GB");
                case .Zimbabwe:
                    return("en");
                case .Argentina:
                    return("es-419");
                case .Brazil:
                    return("pt-BR");
                case .Canada_French:
                    return("fr-CA");
                case .Canada_English:
                    return("en-CA");
                case .Chile:
                    return("es-419");
                case .Colombia:
                    return("es-419");
                case .Cuba:
                    return("es-419");
                case .Mexico:
                    return("es-419");
                case .Peru:
                    return("es-419");
                case .United_States_English:
                    return("en");
                case .United_States_Spanish:
                    return("es-419");
                case .Venezuela:
                    return("es-419");
                default:
                    return("");
                }
            }
        }
        
        case OnlyHeadlines;
        
        fileprivate var outputParameters: String{
            switch self {
            case .OutputFormat:
                return("output=");
            case .HostLanguage:
                return("hl=");
            case .OnlyHeadlines:
                return("hdlOnly=1");
            default:
                return("");
            }
        }
    }
    
    var outputMain: [OutputParameters] = [OutputParameters]();//Main 'OutputParameters'
    var outputFormat: OutputParameters.Output? = nil;//Output format.  Needed if 'OutputFormat' is chosen for main 'OutputParameters'
    var outputLanguage: OutputParameters.Language? = nil;//Output language.  Neede if 'HostLanguage' is chosen for main 'OutputParameters'
}

public struct EndEGoogleFeedComponents{//Components of the URL Feed
    
    public var googleNewsBaseURL: String;/* The chosen base URL */
    public var searchParameters: EndEGoogleSearchParameters;//Search Perms
    public var filtersAndValues: EndEGoogleFilterParameters;//Chosen filter parameters
    public var orderParameters: EndEGoogleOrderParameters;//The chosen order parameter
    public var paginationParameters: EndEGooglePaginationParameters;//The chosen pagination parameter
    public var outputParameters: EndEGoogleOutputParameters;//The chosen output parameters
}

//Protocol defining all the components a conforming class should/can provide to create a valid Google News URL feed
public protocol EndEGoogleFeedComponentsPR: class{
    
    var endeGoogleFeedComponents: EndEGoogleFeedComponents {get set}//Allow a conforming class to set and get feed component properties
    init();
}

public extension EndEGoogleFeedComponentsPR{//Create an extension to allow a conforming class to set their own feed components via easy to use getters/setters
    
   public var googleNewsBaseURL: String{//Do *NOT* include a trailing '&' if customizing your base URL.  The assembleNewsFeedURL function currently assumes no trailing '&' is present
        get{
            return(endeGoogleFeedComponents.googleNewsBaseURL);
        }
        set{
            endeGoogleFeedComponents.googleNewsBaseURL = newValue;
        }
    }
    
   public var googleSearchParameters: EndEGoogleSearchParameters{
        get{
            return(endeGoogleFeedComponents.searchParameters);
        }
        set{
            endeGoogleFeedComponents.searchParameters = newValue;
        }
    }
    
   public var googleFiltersAndValues: EndEGoogleFilterParameters{
        get{
            return(endeGoogleFeedComponents.filtersAndValues);
        }
        set{
            endeGoogleFeedComponents.filtersAndValues = newValue;
        }
    }
    
   public var googleOrderParameters: EndEGoogleOrderParameters{
        get{
            return(endeGoogleFeedComponents.orderParameters);
        }
        set{
            endeGoogleFeedComponents.orderParameters = newValue;
        }
    }
    
   public var googlePaginationParameters: EndEGooglePaginationParameters{
        get{
            return(endeGoogleFeedComponents.paginationParameters);
        }
        set{
            endeGoogleFeedComponents.paginationParameters = newValue;
        }
    }
    
   public var googleOutputParameters: EndEGoogleOutputParameters{
        get{
            return(endeGoogleFeedComponents.outputParameters);
        }
        set{
            endeGoogleFeedComponents.outputParameters = newValue;
        }
    }
}

public class EndEGoogleNewsManager: NSObject{
    
    private var initializerError: EndEError!;//The data initializer error object
    
    private var searchString: String = "";//String assembled from search term parameter(s)
    private var filterString: String = "";//String assembled from filter parameter(s)
    private var orderString: String = "";//String assembled from ordering/sorting parameter(s)
    private var paginateString: String = "";//String assembled from paginatioin paramater(s)
    private var outputString: String = "";//String assembled from output parameter(s)
    
    private var entireRequestURL: String = "";//The fully formed request URL containing all desired request parameters
    
    public static let googleNewsManager: EndEGoogleNewsManager = EndEGoogleNewsManager();//Singleton for access to a single Google News Manager
    
    //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // Assemble the Google News URL feed. Usage: Provide an EndEGoogleFeedCompoentsPR conforming object to assemble the Feed URL
    //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    public func assembleGoogleNewsFeedURL(googleFeedURLComponents: EndEGoogleFeedComponentsPR) -> String{
        
        //Make sure all the components of the entire request URL are blank.  This is necessary here in case this method is called multiple times
        searchString = "";//String assembled from search term parameter(s)
        filterString = "";//String assembled from filter parameter(s)
        orderString = "";//String assembled from ordering/sorting parameter(s)
        paginateString = "";//String assembled from paginatioin paramater(s)
        outputString = "";//String assembled from output parameter(s)
        entireRequestURL = "";//The fully formed request URL containing all desired request parameters
        
        //Track the *first* time a custom parameter is entered.  Used to add the *first* '&' character to the start of the custom URL string
        var addFirstAmpersand: Bool = false;
        
        //Process the search term(s)
        let search = EndEGoogleSearchParameters.SearchParameters.Terms;
    
            for term in googleFeedURLComponents.googleSearchParameters.searchTerms{//Assemble the search terms string
                if((term != "") && (addFirstAmpersand == false)){ self.searchString = "&"; addFirstAmpersand = true; }//Add the *first* '&'
                self.searchString = self.searchString + search.searchParam + term.replacingOccurrences(of: " ", with: "+") + "&";//Note: In case the term has a space(s) in it, replace it with a '+' that is expected in a URL
            }
        
        //Process the filters
        let mainFilters = googleFeedURLComponents.googleFiltersAndValues.filtMain;
        for filter in mainFilters{
            if((filter.filterParam != "") && (addFirstAmpersand == false)){ self.filterString = "&"; addFirstAmpersand = true; }//Add the *first* '&'
            switch(filter){
                case .ArticleAtSpecificTime:
                    self.filterString = self.filterString + self.processFilterArticleAtSpecificTime(filterMain: filter, filterArticleAtSpecificTime: googleFeedURLComponents.googleFiltersAndValues.filtSpecificTime);
                case .ArticleBetweenSpecificTimes:
                    self.filterString = self.filterString + self.processFilterArticleBetweenSpecificTimes(filterMain: filter, filterArticleBetweenSpecificTimesMin: googleFeedURLComponents.googleFiltersAndValues.filtBetweenTimesMinVal, filterArticleBetweenSpecificTimesMax: googleFeedURLComponents.googleFiltersAndValues.filtBetweenTimesMaxVal, filterBetweenTimesParams: googleFeedURLComponents.googleFiltersAndValues.filtBetweenTimesParameters);
                case .ArticleLocation:
                    self.filterString = self.filterString + self.processFilterArticleLocation(filterMain: filter, filterArticleLocation: googleFeedURLComponents.googleFiltersAndValues.filtLocation);
                case .ArticleTopic:
                    self.filterString = self.filterString + self.processFilterTopic(filterMain: filter, filterParams: googleFeedURLComponents.googleFiltersAndValues);
                case .ArticleEdition:
                    self.filterString = self.filterString + self.processFilterEdition(filterMain: filter, filterEdition: googleFeedURLComponents.googleFiltersAndValues.filtEdition);
                case .ArticleSource:
                    self.filterString = self.filterString + self.processFilterSource(filterMain: filter, filterSource: googleFeedURLComponents.googleFiltersAndValues);
                case .ArticleSourceLocation:
                    self.filterString = self.filterString + self.processFilterSourceLocation(filterMain: filter, filterSourceLocation: googleFeedURLComponents.googleFiltersAndValues);
                case .ArticleAuthor:
                    self.filterString = self.filterString + self.processFilterAuthor(filterMain: filter, filterAuthor: googleFeedURLComponents.googleFiltersAndValues);
                default:
                    self.filterString = "";
            }
        }
        
        //Process the order selection
        if((googleFeedURLComponents.googleOrderParameters.oParam.orderParam != "") && (addFirstAmpersand == false)){ self.orderString = "&"; addFirstAmpersand = true; }//Add the *first* '&'
        if googleFeedURLComponents.googleOrderParameters.oChoice != nil { self.orderString = self.orderString + googleFeedURLComponents.googleOrderParameters.oParam.orderParam + googleFeedURLComponents.googleOrderParameters.oChoice!.orderChoices + "&"; }
        
        //Process the pagination selection
        if((googleFeedURLComponents.googlePaginationParameters.paginationParam.paginationParameters != "") && (addFirstAmpersand == false)){ self.paginateString = "&"; addFirstAmpersand = true; }//Add the *first* '&'
        self.paginateString = self.paginateString + googleFeedURLComponents.googlePaginationParameters.paginationParam.paginationParameters + googleFeedURLComponents.googlePaginationParameters.paginationValue.description + "&";
        
        //Process the output selection
        let mainOutput = googleFeedURLComponents.googleOutputParameters.outputMain;
        for outputSetting in mainOutput{
            if((googleFeedURLComponents.googleOrderParameters.oParam.orderParam != "") && (addFirstAmpersand == false)){ self.orderString = "&"; addFirstAmpersand = true; }//Add the *first* '&'
            switch(outputSetting){
                case .OutputFormat:
                    if googleFeedURLComponents.googleOutputParameters.outputFormat != nil { self.outputString = self.outputString + outputSetting.outputParameters + googleFeedURLComponents.googleOutputParameters.outputFormat!.outputFormat + "&"; }
                case .HostLanguage:
                    if googleFeedURLComponents.googleOutputParameters.outputLanguage != nil { self.outputString = self.outputString + outputSetting.outputParameters + googleFeedURLComponents.googleOutputParameters.outputLanguage!.languageChoices + "&"; }
                case .OnlyHeadlines:
                    self.outputString = self.outputString + outputSetting.outputParameters + "&";
                default:
                    self.outputString = "";
            }
        }
        
        self.entireRequestURL = googleFeedURLComponents.googleNewsBaseURL + self.searchString + self.filterString + self.orderString + self.paginateString + self.outputString;
        self.entireRequestURL = self.entireRequestURL.substring(to: self.entireRequestURL.index(before: self.entireRequestURL.endIndex));
        
        return(entireRequestURL);
    }
    
    //Filter processing helpers
    //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    private func processFilterArticleAtSpecificTime(filterMain: EndEGoogleFilterParameters.FilterParameters, filterArticleAtSpecificTime: EndEGoogleFilterParameters.FilterParameters.SpecificTimeVals?) -> String{//Process the ArticleAtSpecificTime filter.  Return sub-URL string pertaining to this filter
        guard filterArticleAtSpecificTime != nil else{
            return("");
        }
        var subURL: String = "";//The sub URL string
        subURL = subURL + filterMain.filterParam;
        subURL = subURL + filterArticleAtSpecificTime!.filterBySpecificTimeOptions + "&";
        return(subURL);
    }
    
    private func processFilterArticleBetweenSpecificTimes(filterMain: EndEGoogleFilterParameters.FilterParameters, filterArticleBetweenSpecificTimesMin: EndEGoogleFilterParameters.FilterParameters.BetweenSpecificTimes?, filterArticleBetweenSpecificTimesMax: EndEGoogleFilterParameters.FilterParameters.BetweenSpecificTimes?, filterBetweenTimesParams: EndEGoogleFilterParameters.FiltBetweenTimesGroup?) -> String{//Process the ArticleAtSpecificTime filter.  Return sub-URL string pertaining to this filter
        guard filterArticleBetweenSpecificTimesMin != nil, filterArticleBetweenSpecificTimesMax != nil, filterBetweenTimesParams != nil else{
            return("");
        }
        var subURL: String = "";//The sub URL string
        subURL = subURL + filterMain.filterParam;
        subURL = subURL + filterArticleBetweenSpecificTimesMin!.filterBetweenSpecificTimes + filterBetweenTimesParams!.minimumDayOrMonth + "&";
        subURL = subURL + filterArticleBetweenSpecificTimesMax!.filterBetweenSpecificTimes + filterBetweenTimesParams!.maximumDayOrMonth + "&";
        return(subURL);
    }
    
    private func processFilterArticleLocation(filterMain: EndEGoogleFilterParameters.FilterParameters, filterArticleLocation: EndEGoogleFilterParameters.FilterParameters.FilterLocation?) -> String{
        guard filterArticleLocation != nil else{
            return("");
        }
        var subURL: String = "";//The sub URL string
        subURL = subURL + filterMain.filterParam;
        subURL = subURL + filterArticleLocation!.filterLocationOptions + "&";
        return(subURL);
    }
    
    private func processFilterTopic(filterMain: EndEGoogleFilterParameters.FilterParameters, filterParams: EndEGoogleFilterParameters) -> String{
        guard filterParams.filtTopic != nil else{
            return("");
        }
        var subURL: String = "";//The sub URL string
        subURL = subURL + filterMain.filterParam;
        subURL = subURL + filterParams.filtTopic! + "&";
        return(subURL);
    }
    
    private func processFilterEdition(filterMain: EndEGoogleFilterParameters.FilterParameters, filterEdition: EndEGoogleFilterParameters.FilterParameters.Edition?) -> String{
        guard filterEdition != nil else{
            return("");
        }
        var subURL: String = "";//The sub URL string
        subURL = subURL + filterMain.filterParam;
        subURL = subURL + filterEdition!.editionChoice + "&";
        return(subURL);
    }
    
    private func processFilterSource(filterMain: EndEGoogleFilterParameters.FilterParameters, filterSource: EndEGoogleFilterParameters) -> String{
        guard filterSource.filtSource != nil else{
            return("");
        }
        var subURL: String = "";//The sub URL string
        subURL = subURL + filterMain.filterParam;
        subURL = subURL + filterSource.filtSource! + "&";
        return(subURL);
    }
    
    private func processFilterSourceLocation(filterMain: EndEGoogleFilterParameters.FilterParameters, filterSourceLocation: EndEGoogleFilterParameters) -> String{
        guard filterSourceLocation.filtSourceLocation != nil else{
            return("");
        }
        var subURL: String = "";//The sub URL string
        subURL = subURL + filterMain.filterParam;
        subURL = subURL + filterSourceLocation.filtSourceLocation! + "&";
        return(subURL);
    }
    
    private func processFilterAuthor(filterMain: EndEGoogleFilterParameters.FilterParameters, filterAuthor: EndEGoogleFilterParameters) -> String{
        guard filterAuthor.filtAuthor != nil else{
            return("");
        }
        var subURL: String = "";//The sub URL string
        subURL = subURL + filterMain.filterParam;
        subURL = subURL + filterAuthor.filtAuthor! + "&";
        return(subURL);
    }
    //------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
}
