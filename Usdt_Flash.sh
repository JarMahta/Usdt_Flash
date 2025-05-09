#!/bin/bash

balance=1000000
account_id="TASsP1Uerf77BpX8TJeZrfDanVDypsABk2"

usdt_logo=" \e[38;2;38;161;123m$$$$$$\ $$  __$$\ $$ /  \__| $$$$$$\  $$\   $$\  $$$$$$\$$$$\   $$$$$$\   $$$$$$\  $$$$$$$\ \e[38;2;38;161;123m\$$$$$$\  $$  __$$\ $$ |  $$ |$$  _$$  _$$\  \____$$\ $$  __$$\ $$  __$$\  \____$$\ $$ /  $$ |$$ |  $$ |$$ / $$ / $$ | $$$$$$$ |$$ /  $$ |$$ |  $$ | $$\   $$ |$$ |  $$ |$$ |  $$ |$$ | $$ | $$ |$$  __$$ |$$ |  $$ |$$ |  $$ | \e[38;2;38;161;123m\$$$$$$  |\$$$$$$  |\$$$$$$  |$$ | $$ | $$ |\$$$$$$$ |\$$$$$$  |$$ |  $$ |  \______/  \______/  \______/ \__| \__| \__| \_______| \______/ \__|  \__| \e[0m"

function fancyBoxEcho {
    local message="$1"
    local length=${#message}
    local border=$(printf '=%.0s' $(seq 1 $((length + 4))))

    echo -e "\e[38;2;38;161;123m$border\e[0m"
    echo -e "\e[38;2;38;161;123m| $message |\e[0m"
    echo -e "\e[38;2;38;161;123m$border\e[0m"
}

welcome_message="Welcome to the USDT Flash Software! Enjoy the power of Flash USDT!"

echo -e "$usdt_logo"
fancyBoxEcho "$welcome_message"

function unlockBalance {
    echo " "
    echo -e "\e[32mProceeding without deposit verification...\e[0m"
    echo " "
    sleep 2
    selectNetwork
}

function selectNetwork {
    echo -e "\e[34mSelect network:\e[0m"
    echo " "
    echo "1. TRC20"
    echo "2. ERC20"
    echo "3. BEP20"
    echo " "
    echo -n "Enter your choice: "
    read network_choice

    case $network_choice in
        1) network="TRC20";;
        2) network="ERC20";;
        3) network="BEP20";;
        *)
            echo -e "\e[31mInvalid choice, please try again.\e[0m"
            selectNetwork
            return
            ;;
    esac

    selectWithdrawalAmount
}

function clearScreen {
    sleep 1.5
    clear
}

function selectWithdrawalAmount {
    clearScreen
    echo -e "\e[34mSelect withdrawal amount:\e[0m"
    echo "1. 1000000"
    echo "2. 500000"
    echo "3. 300000"
    echo "4. 100000"
    echo " "
    echo -n -e "\e[32mEnter Your Option: \e[0m"
    read amount_choice

    case $amount_choice in
        1) amount=1000000;;
        2) amount=500000;;
        3) amount=300000;;
        4) amount=100000;;
        *)
            echo -e "\e[31mInvalid choice, please try again.\e[0m"
            selectWithdrawalAmount
            return
            ;;
    esac

    read -p "Enter your withdrawal address: " withdrawal_address

    if [[ ${#withdrawal_address} -lt 10 ]]; then
        echo -e "\e[31mError: Invalid withdrawal address. Please try again.\e[0m"
        selectWithdrawalAmount
        return
    fi

    echo ""
    echo -e "\e[32mSending Funds....\e[0m"
    sleep 4
    echo -e "[+] Withdrawal of $amount USDT successful to address $withdrawal_address on $network network. [+]"
    exit
}

function refresh {
    echo "Refreshing..."
    sleep 2
    clear
    echo -e "$usdt_logo"
    echo " "
    fancyBoxEcho "$welcome_message"
}

refresh

while true; do
    unlockBalance
done

exit
