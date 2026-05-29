#!/bin/bash
while true; do
    read -r -p "Do you want to add to \$PATH (type \"1\") or to a custom directory (type \"2\")? " script_location
    if [[ "$script_location" == "1" ]]; then
        target_dir="$HOME/bin"
        break
    elif [[ "$script_location" == "2" ]]; then
        echo "A custom directory will not be added to \$PATH, but can be added manually by the user later."
        while true; do
            read -r -p "Please enter your desired directory path: " custom_path
            if [[ -d "$custom_path" ]]; then
                target_dir="$custom_path"
                break 2
            else
                echo "That directory is invalid. Please try again."
            fi
        done
    else
        echo "Please enter a valid input."
    fi
done

mkdir -p "$target_dir"
if [[ ! -d "$target_dir" ]]; then
    echo "Failed to create $target_dir. Aborting."
    exit 1
fi

if [[ -f "$target_dir/ussh" ]]; then
    echo "ussh exists. Skipping..."
else
    cat > "$target_dir/ussh" << 'EOF'
#!/bin/bash
current_host_datetime=$(date "+%Y-%m-%d %H:%M:%S")
ssh ubuntu@10.42.0.1 "sudo date -s \"$current_host_datetime\""
ssh ubuntu@10.42.0.1
EOF
    chmod +x "$target_dir/ussh"
fi

read -r -p "Do you want to set up an SSH key? Y/N " key_binary
if [[ "$key_binary" =~ ^[Yy] ]]; then
    if [[ -f "$HOME/.ssh/id_ed25519" ]]; then
        echo "Key already exists. Skipping step..."
        key_setup=true
    else
        ssh-keygen -t ed25519
        key_setup=true
    fi
else
    echo "Ok, we will skip key generation."
    key_setup=false
fi

if [[ "$key_setup" == "true" ]]; then
    echo "Connect to the Pi's hotspot, then run ssh-copy-id ubuntu@10.42.0.1. Then run ussh."
else
    echo "Connect to the Pi's hotspot, then run ussh. It will prompt for the Pi's password."
fi
