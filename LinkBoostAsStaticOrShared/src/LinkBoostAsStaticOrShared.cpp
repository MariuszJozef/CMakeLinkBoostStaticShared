#include <boost/regex.hpp>
#include <boost/date_time/gregorian/gregorian.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>
#include "LinkBoostAsStaticOrShared.hpp"

namespace BoostEx
{

Data::Data(int x1, double x2, char x3, const std::string& x4)
    : x1(x1)
    , x2(x2)
    , x3(x3)
    , x4(x4)
{}

void Data::ShowData(const std::string& info)
{
    std::cout << info 
        << ": x1 = " << x1 
        << ", x2 = " << x2 
        << ", x3 = " << x3 
        << ", x4 = " << x4 << "\n";
}

void Data::SaveData(std::ostringstream& oss)
{
    boost::archive::binary_oarchive oa(oss);
    oa&* (this);
}

void Data::LoadData(std::ostringstream& oss)
{
    std::string str_data = oss.str();
    std::istringstream iss(str_data);
    boost::archive::binary_iarchive ia(iss);
    ia&* (this);
}

// BOOST_CLASS_VERSION(Data, 1)

std::ostringstream storeData;

void SerializeData()
{
    Data data(1, 1.2, 'a', "Abcd");
    data.ShowData("SerializeData");

    data.SaveData(storeData);

    Data retrieveData;
    retrieveData.ShowData("DeserializeData");
}

void DeserializeData()
{
    Data retrieveData;
    retrieveData.ShowData("DeserializeData");

    retrieveData.LoadData(storeData);
    // retrieveData.LoadData(retrieveData);
    retrieveData.ShowData("DeserializeData");
}

void Regex()
{
    std::cout << "Regex\n";
    std::string url = "http://mydomain.com/randompage.php";
    boost::regex exp("^https?://([^/]*?)/");
    boost::smatch match;

    if (boost::regex_search(url, match, exp))
    {
        std::cout << std::string(match[1].first, match[1].second) << "\n";
    }
    else
    {
        std::cout << "No regex match\n";
    }
}

void BoostDateEx1()
{
    boost::gregorian::date someDate {1687, 8, 3};
    std::cout << "someDate = " << someDate << "\n";

    someDate += boost::gregorian::years(3);
    someDate += boost::gregorian::months(-5);
    someDate -= boost::gregorian::days(8);
    std::cout << "someDate = " << someDate << "\n";
}

void BoostTimeEx1()
{
    boost::posix_time::time_duration someTime {8, 9, 11};
    std::cout << "someTime = " << someTime << "\n";

    someTime += boost::posix_time::hours(2);
    someTime += boost::posix_time::minutes(-12);
    someTime -= boost::posix_time::seconds(17);
    std::cout << "someTime = " << someTime << "\n";

    someTime = boost::posix_time::time_duration(
        boost::posix_time::hours(13)
        + boost::posix_time::minutes(-14)
        - boost::posix_time::seconds(15));
    std::cout << "someTime = " << someTime << "\n";
}

} // ~namespace BoostEx
