#include <string>
#include <boost/mpi.hpp>

namespace application {

class application {
public:
    application() = default;
    application(const application&) = delete;
    application& operator=(const application&) = delete;
    application(application&&) noexcept = delete;
    application& operator=(application&&) noexcept = delete;
    ~application() = default;

    int run(int argc, char** argv);

private:
    std::string _log_level;

    bool parse_args(int argc, char** argv);

    int _run_openmp(int argc, char** argv);
    int _run_stdthread(int argc, char** argv);
};

} // namespace application
