#!/bin/bash
set -euo pipefail  # Прерывать при ошибках, неопределённых переменных, ошибках в пайпах

# --- Логирование ---
LOG_FILE="script.log"
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# --- Последовательное выполнение ---
run_sequential() {
    log "=== Запуск ПОСЛЕДОВАТЕЛЬНЫХ команд ==="
    
    # Примеры реальных команд:
    local commands=(
        "ls -l /etc/passwd"            # Проверка существования файла
        "grep 'root' /etc/passwd"      # Поиск пользователя root
        "mkdir -p ./test_dir"          # Создание директории
        "touch ./test_dir/file.txt"    # Создание файла
    )
    
    for cmd in "${commands[@]}"; do
        log "Выполняю: $cmd"
        if ! eval "$cmd"; then
            log "ОШИБКА: команда '$cmd' завершилась с кодом $?"
            return 1
        fi
    done
    
    log "Все последовательные команды выполнены успешно!"
    return 0
}

# --- Параллельное выполнение ---
run_parallel() {
    log "=== Запуск ПАРАЛЛЕЛЬНЫХ команд ==="
    
    # Примеры реальных команд:
    local commands=(
        "curl -s https://example.com > example.html"  # Скачать страницу
        "sleep 2 && echo 'Sleep done'"               # Имитация долгой задачи
        "tar -czf backup.tar.gz ./test_dir"          # Архивировать директорию
    )
    
    local pids=()
    local max_jobs=2  # Максимум 2 параллельных задачи
    
    # Запуск команд в фоне
    for cmd in "${commands[@]}"; do
        while [[ $(jobs -r | wc -l) -ge $max_jobs ]]; do
            sleep 0.1  # Ждём, если достигли лимита потоков
        done
        
        log "Запускаю параллельно: $cmd"
        eval "$cmd" &
        pids+=($!)
    done
    
    # Ожидание завершения и проверка ошибок
    local error=0
    for pid in "${pids[@]}"; do
        if ! wait "$pid"; then
            log "ОШИБКА: процесс $pid завершился с кодом $?"
            error=1
        fi
    done
    
    [[ $error -eq 0 ]] && log "Все параллельные команды выполнены успешно!"
    return $error
}

# --- Основной код ---
main() {
    echo "Логирование в файл: $LOG_FILE"
    
    # Последовательный запуск
    if ! run_sequential; then
        log "Скрипт остановлен из-за ошибки в последовательных командах"
        exit 1
    fi
    
    # Параллельный запуск
    if ! run_parallel; then
        log "Обнаружены ошибки в параллельных командах, но продолжаем работу"
    fi
    
    # Финализация
    log "=== Скрипт завершён ==="
}

main "$@"