# -*-Shell-script-*-

function awsswitch()
{
    local AWS="${1}"
    if [ "$AWS" == "" ] ; then
        echo "invalid aws"
    else
        if [ "${AWS}" == "none" ] ; then
            rm "${HOME}/.awsaccount" &> /dev/null
        else
            grep -e "${AWS}" "${HOME}/.aws.yml" &> /dev/null
            if [ $? != 0 ] ; then
                echo "invalid aws"
            else
                "${AWSSWITCH_PATH}/awsswitch.sh" use $1 && eval $("${AWSSWITCH_PATH}/awsswitch.sh" eval)
            fi
        fi
    fi
}

function awsregion()
{
    local REGION="${1}"
    aws ec2 describe-regions | cut -f 3 | grep $REGION &> /dev/null
    if [ $? != 0 ] ; then
        echo "invalid region"
    else
        AWS_DEFAULT_REGION=$REGION
    fi
}

function awslist()
{
    "${AWSSWITCH_PATH}/awsswitch.sh" list
}
