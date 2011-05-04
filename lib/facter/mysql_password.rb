Facter.add("mysql_password") do
    ENV["PATH"]="/bin:/sbin:/usr/bin:/usr/sbin"
    
    setcode do
        %x"test -f /root/.my.cnf && cat /root/.my.cnf | grep 'password' | head -n 1 | awk -F'=' '{print $2}'".strip
    end
end
