From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 6/6] i2cset: Get command/mode before reading data
Date: Mon, 14 Feb 2011 10:43:41 +0100
Message-ID: <20110214104341.3791fddb@endymion.delvare>
References: <1297628246-19367-1-git-send-email-guenter.roeck@ericsson.com>
	<1297628246-19367-7-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297628246-19367-7-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 13 Feb 2011 12:17:26 -0800, Guenter Roeck wrote:
> Get and validate the command/mode parameter for all commands
> before reading and evaluating actual data.
> 
> Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> ---
>  tools/i2cset.c |   99 +++++++++++++++++++++++++++++++-------------------------
>  1 files changed, 55 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/i2cset.c b/tools/i2cset.c
> index 33290ef..d8d51a2 100644
> --- a/tools/i2cset.c
> +++ b/tools/i2cset.c
> @@ -207,18 +207,37 @@ int main(int argc, char *argv[])
>  		help();
>  	}
>  
> -	/* check for block data */
> -	len = 0;
> -	if (argc > flags + 5) {
> +	/* check for command/mode */
> +	if (argc == flags + 4) {
> +		/* Implicit "c" */
> +		size = I2C_SMBUS_BYTE;
> +	} else if (argc == flags + 5) {
> +		/* "c", "cp",  or implicit "b" */
> +		if (!strcmp(argv[flags+4], "c")
> +		 || !strcmp(argv[flags+4], "cp")) {
> +			size = I2C_SMBUS_BYTE;
> +			pec = argv[flags+4][1] == 'p';
> +		} else {
> +			size = I2C_SMBUS_BYTE_DATA;
> +		}
> +	} else {
> +		/* All other commands */
> +		if (strlen(argv[argc-1]) > 2
> +		    || (strlen(argv[argc-1]) == 2 && argv[argc-1][1] != 'p')) {
> +			fprintf(stderr, "Error: Invalid mode '%s'!\n", argv[argc-1]);
> +			help();
> +		}
>  		switch (argv[argc-1][0]) {
> +		case 'b': size = I2C_SMBUS_BYTE_DATA; break;
> +		case 'w': size = I2C_SMBUS_WORD_DATA; break;
>  		case 's': size = I2C_SMBUS_BLOCK_DATA; break;
>  		case 'i': size = I2C_SMBUS_I2C_BLOCK_DATA; break;
>  		default:
> -			size = 0;
> -			break;
> +			fprintf(stderr, "Error: Invalid mode '%s'!\n", argv[argc-1]);
> +			help();
>  		}
> +		pec = argv[argc-1][1] == 'p';
>  		if (size == I2C_SMBUS_BLOCK_DATA || size == I2C_SMBUS_I2C_BLOCK_DATA) {
> -			pec = argv[argc-1][1] == 'p';
>  			if (argc > (int)sizeof(block) + flags + 5) {
>  				fprintf(stderr, "Error: Bad number of arguments!\n");
>  				help();
> @@ -231,49 +250,48 @@ int main(int argc, char *argv[])
>  				fprintf(stderr, "Error: Mask not supported for block writes!\n");
>  				help();
>  			}
> -			for (len = 0; len + flags + 5 < argc; len++) {
> -				value = strtol(argv[flags + len + 4], &end, 0);
> -				if (*end || value < 0 || value > 0xff) {
> -                                	fprintf(stderr, "Error: Block data value invalid!\n");
> -                                	help();
> -                        	}
> -				block[len] = value;
> -			}
> -			goto dofile;
>  		} else if (argc != flags + 6) {
>  			fprintf(stderr, "Error: Bad number of arguments!\n");
>  			help();
>  		}
>  	}
>  
> -	if (argc > flags + 4) {
> -		if (!strcmp(argv[flags+4], "c")
> -		 || !strcmp(argv[flags+4], "cp")) {
> -			size = I2C_SMBUS_BYTE;
> -			value = -1;
> -			pec = argv[flags+4][1] == 'p';
> -		} else {
> -			size = I2C_SMBUS_BYTE_DATA;
> -			value = strtol(argv[flags+4], &end, 0);
> +	len = 0; /* Must always initialize len since it is passed to confirm() */
> +
> +	/* read values from command line */
> +	switch (size) {
> +	case I2C_SMBUS_BYTE_DATA:
> +	case I2C_SMBUS_WORD_DATA:
> +		value = strtol(argv[flags+4], &end, 0);
> +		if (*end || value < 0) {
> +			fprintf(stderr, "Error: Data value invalid!\n");
> +			help();
> +		}
> +		if ((size == I2C_SMBUS_BYTE_DATA && value > 0xff)
> +		    || (size == I2C_SMBUS_WORD_DATA && value > 0xffff)) {
> +			fprintf(stderr, "Error: Data value out of range!\n");
> +			help();
> +		}
> +		break;
> +	case I2C_SMBUS_BLOCK_DATA:
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		for (len = 0; len + flags + 5 < argc; len++) {
> +			value = strtol(argv[flags + len + 4], &end, 0);
>  			if (*end || value < 0) {
>  				fprintf(stderr, "Error: Data value invalid!\n");
>  				help();
>  			}
> +			if (value > 0xff) {
> +				fprintf(stderr, "Error: Data value out of range!\n");
> +				help();
> +			}
> +			block[len] = value;
>  		}
> -	} else {
> -		size = I2C_SMBUS_BYTE;
>  		value = -1;
> -	}
> -
> -	if (argc > flags + 5) {
> -		switch (argv[flags+5][0]) {
> -		case 'b': size = I2C_SMBUS_BYTE_DATA; break;
> -		case 'w': size = I2C_SMBUS_WORD_DATA; break;
> -		default:
> -			fprintf(stderr, "Error: Invalid mode!\n");
> -			help();
> -		}
> -		pec = argv[flags+5][1] == 'p';
> +		break;

You could use a fall-through here.

> +	default:
> +		value = -1;
> +		break;
>  	}
>  
>  	if (maskp) {
> @@ -284,13 +302,6 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> -	if ((size == I2C_SMBUS_BYTE_DATA && value > 0xff)
> -	 || (size == I2C_SMBUS_WORD_DATA && value > 0xffff)) {
> -		fprintf(stderr, "Error: Data value out of range!\n");
> -		help();
> -	}
> -
> -dofile:
>  	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
>  	if (file < 0

>  	 || check_funcs(file, size, pec)

Other than this minor comment (which you may not even agree with), this
patch looks OK to me now. Thanks.

-- 
Jean Delvare
