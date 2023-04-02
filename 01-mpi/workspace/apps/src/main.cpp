#include "application.hpp"

int main(int argc, char** argv) {
    application::application app{};
    return app.run(argc, argv);
}
