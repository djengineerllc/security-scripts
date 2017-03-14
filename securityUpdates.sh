#!/bin/bash
DO_UPDATE=0
DFLT_DIR=/var/www/
DFLT_EXCLUDE=*.{db,md,txt}
NONCE=${1:-"random31234125"}
#IPV4 to IPV6 link updates
declare -A Swap0=(
        [old]="\/\/code.jquery.com\/jquery-1.12.0.min.js"
        [new]="\/\/cdnjs.cloudflare.com\/ajax\/libs\/jquery\/1.12.0\/jquery.min.js"
        [working_dir]="$DFLT_DIR"
        [exclude]="$DFLT_EXCLUDE"
        [update]=1
)
declare -A Swap1=(
        [old]="https:\/\/code.jquery.com\/jquery-1.11.3.min.js"
        [new]="\/\/cdnjs.cloudflare.com\/ajax\/libs\/jquery\/1.11.3\/jquery.min.js"
        [working_dir]="$DFLT_DIR"
        [exclude]="$DFLT_EXCLUDE"
        [update]=1
)
#Update NONCE
declare -A Swap2=(
        [old]="<script src=\""
        [new]="<script nonce=\"$NONCE\" src=\""
        [working_dir]="$DFLT_DIR"
        [exclude]="$DFLT_EXCLUDE"
        [update]=1
)
declare -A Swap3=(
        [old]="<script src='"
        [new]="<script nonce='$NONCE' src='"
        [working_dir]="$DFLT_DIR"
        [exclude]="$DFLT_EXCLUDE"
        [update]=1
)
declare -A Swap4=(
        [old]="<script type=\""
        [new]="<script nonce=\"$NONCE\" type=\""
        [working_dir]="$DFLT_DIR"
        [exclude]="$DFLT_EXCLUDE"
        [update]=1
)
declare -A Swap5=(
        [old]="<script type='"
        [new]="<script nonce=\"$NONCE\" type='"
        [working_dir]="$DFLT_DIR"
        [exclude]="$DFLT_EXCLUDE"
        [update]=1
)
declare -A Swap6=(
        [old]="\"<script>"
        [new]="\"<script nonce='$NONCE'>"
        [working_dir]="$DFLT_DIR"
        [exclude]="$DFLT_EXCLUDE"
        [update]=1
)
declare -A Swap7=(
        [old]="'<script>"
        [new]="'<script nonce=\"$NONCE\""
        [working_dir]="$DFLT_DIR"
        [exclude]="$DFLT_EXCLUDE"
        [update]=1
)
echo "NONCE: ${NONCE}"
#Update SRI for libraries
declare -A Swap8=(
        [old]="src=\"\\/\\/cdnjs.cloudflare.com\\/ajax\\/libs\\/jquery\\/1.12.0\\/jquery.min.js\""
        [new]="integrity=\"sha384-XxcvoeNF5V0ZfksTnV+bejnCsJjOOIzN6UVwF85WBsAnU3zeYh5bloN+L4WLgeNE\" crossorigin=\"anonymous\" src=\"\\/\\/cdnjs.cloudflare.com\\/ajax\\/libs\\/jquery\\/1.12.0\\/jquery.min.js\""
        [working_dir]="$DFLT_DIR"
        [exclude]="$DFLT_EXCLUDE"
        [update]=1
)
declare -A Swap9=(
        [old]="src=\"{{asset \\\"js\/index.js\\\"}}\""
        [new]="integrity=\"sha384-b3Otc7W2sx0XHbEtH2DeVttNyyutIpaE0LNiuhgLvKzf5D3xP0VC+dSith54Oc6O\" crossorigin=\"anonymous\" src=\"{{asset \\\"js\/index.js\\\"}}\""
        [working_dir]="$DFLT_DIR"
        [exclude]="$DFLT_EXCLUDE"
        [update]=1
)
declare -A Swap10=(
        [old]="src=\"{{asset \\\"js\/jquery.fitvids.js\\\"}}\""
        [new]="integrity=\"sha384-LbM+OJR9yNYLhE1kBdQUvrAhQXsPvlu7OEWaouyHbsQEWmusRMQjJ6C1WF4TYDVq\" crossorigin=\"anonymous\" src=\"{{asset \\\"js\/jquery.fitvids.js\\\"}}\""
        [working_dir]="$DFLT_DIR"
        [exclude]="$DFLT_EXCLUDE"
        [update]=1
)
for item in ${!Swap@}; do
        declare -n swap=$item
        if [ "${swap[update]}" == "1" ]; then
                grep -rn "${swap[old]}" ${swap[working_dir]} --exclude=${swap[exclude]}
                if [ "$DO_UPDATE" == "1" ]; then
                        grep -rl "${swap[old]}" ${swap[working_dir]} --exclude=${swap[exclude]} | xargs sed -i "s/${swap[old]}/${swap[new]}/g"
                fi
        fi
done