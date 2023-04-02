#include "application.hpp"
#include "spdlog/spdlog.h"
#include "cxxopts.hpp"
#include "fmt/core.h"

#include <boost/mpi.hpp>
#include <boost/asio.hpp>

namespace mpi = boost::mpi;
namespace ip = boost::asio::ip;

namespace application {

int application::run(int argc, char** argv) {
    if (!parse_args(argc, argv)) {
        return 1;
    }

    spdlog::set_level(spdlog::level::from_str(_log_level));
    if (spdlog::get_level() == spdlog::level::off) {
        spdlog::error("Invalid log level: {}", _log_level);
        return 1;
    }

    mpi::environment env;
    mpi::communicator world;
    boost::asio::io_service io_service;

    auto rank = world.rank();
    auto size = world.size();
    auto host = ip::host_name();

    spdlog::set_pattern(fmt::format("[%H:%M:%S.%e] [%^%l%$] [rank {}] [{}] %v", rank, host));

    spdlog::info("Log level: {}", _log_level);
    spdlog::info("App start!");

    return 0;
}

bool application::parse_args(int argc, char** argv) {
    cxxopts::Options opts("gcs-transceiver", "GCS transceiver");

    // clang-format off
    opts.add_options()
        ("h,help", "Print usage")
        ("log-level", "Verbosity of logs", cxxopts::value<std::string>()->default_value("debug"))
        ;
    // clang-format on

    auto result = opts.parse(argc, argv);

    if (result.count("help")) {
        std::printf("%s\n", opts.help().c_str());
        return false;
    }

    try {
        _log_level = result["log-level"].as<std::string>();
    } catch (const std::exception&) {
        std::printf("%s\n", opts.help().c_str());
        return false;
    }

    return true;
}

} // namespace application
