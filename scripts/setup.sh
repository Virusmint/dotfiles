# setup.sh

case "$(uname)" in
Darwin)
    echo "Detected MacOS"
    ./setup-mac.sh
    ;;
Linux)
    echo "Detected Linux"
    ./setup-linux.sh
    ;;
*)
    echo "Unsupported OS"
    exit 1
    ;;
esac
