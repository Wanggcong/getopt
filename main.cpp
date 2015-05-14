    std::string filter_port;
    std::string interface;
    std::string mcast_ip;
    std::string mcast_port;
    std::string input_filename;
    std::string num_packets = "0";
    bool temporal = false;

    while ( true )
    {
        static struct option long_options[] =
        {
            {"help", no_argument, NULL, 'h'},
            {"filter", required_argument, NULL, 'f'},
            {"interface", required_argument, NULL, 'i'},
            {"mcast", required_argument, NULL, 'm'},
            {"num_packets", required_argument, NULL, 'n'},
            {"port", required_argument, NULL, 'p'},
            {"read", required_argument, NULL, 'r'},
            {"temporal", no_argument, NULL, 't'},
        };

        const int c = ::getopt_long( argc, argv, "hf:i:m:n:p:r:t", long_options, NULL );
        if ( c == -1 ) break;

        switch ( c )
        {
            case 'f':
                filter_port = optarg;
                break;

            case 'i':
                interface = optarg;
                break;

            case 'm':
                mcast_ip = optarg;
                break;

            case 'n':
                num_packets = optarg;
                break;

            case 'p':
                mcast_port = optarg;
                break;

            case 'r':
                input_filename = optarg;
                break;

            case 't':
                temporal = true;
                break;

            case 'h':
            case '?':
            default:
                usage( argv[0] );
                return 1;
        }
    } // while
