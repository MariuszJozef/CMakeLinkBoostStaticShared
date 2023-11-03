#pragma once
#include <iostream>
#include <sstream>
#include <string>
#include <boost/archive/binary_iarchive.hpp> 
#include <boost/archive/binary_oarchive.hpp>

namespace BoostEx
{

class Data
    {
    public:
        Data() = default;
        Data(int x1, double x2, char x3, const std::string& x4);

        void ShowData(const std::string& info);
        void SaveData(std::ostringstream& oss);
        void LoadData(std::ostringstream& oss);

    private:
        int x1 {};
        double x2 {};
        char x3 {};
        std::string x4{};

        friend class boost::serialization::access;

        template <typename Archive>
        void serialize(Archive& archive, const unsigned int version);

    };

template <typename Archive>
void Data::serialize(Archive& archive, const unsigned int version)
{
    archive& x1;
    archive& x2;
    archive& x3;
    archive& x4;

    // if (version > 0) archive& x5;
}

void SerializeData();
void DeserializeData();
void Regex();
void BoostTimeEx1();
void BoostDateEx1();

} // ~namespace BoostEx
