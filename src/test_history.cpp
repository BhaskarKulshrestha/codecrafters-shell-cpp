#include <iostream>
#include <cstdlib>
#include <readline/readline.h>
#include <readline/history.h>

int main() {
    const char* histfile = getenv("HISTFILE");
    if (histfile != nullptr) {
        std::cout << "Loading from: " << histfile << std::endl;
        int result = read_history(histfile);
        std::cout << "read_history returned: " << result << std::endl;
        std::cout << "history_length: " << history_length << std::endl;
        
        for (int i = 0; i < history_length; i++) {
            HIST_ENTRY* entry = history_get(i + history_base);
            if (entry) {
                std::cout << "  " << (i + 1) << "  " << entry->line << std::endl;
            }
        }
    }
    return 0;
}
