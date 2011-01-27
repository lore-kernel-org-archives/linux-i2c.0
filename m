From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2ctools: Add capability to write block command
Date: Thu, 27 Jan 2011 17:59:08 +0100
Message-ID: <20110127175908.488edda3@endymion.delvare>
References: <20110125162106.GA8024@ericsson.com>
	<20110125174922.4c802f49@endymion.delvare>
	<20110127160058.GA16853@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110127160058.GA16853-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Guenter,

On Thu, 27 Jan 2011 08:00:58 -0800, Guenter Roeck wrote:
> This patch adds support to write block data to i2cset.
> 
> I tried to limit the changes as much as possible. Detecting new write modes
> is a bit tricky since the command supports an undocumented parameter (mask)
> after the mode.

This can go away if it bothers you. This was the old way to pass the
mask value. I have implemented -m meanwhile, and this is what people
should be using by now. I added it 2 years ago, so I think it's
acceptable to stop supporting the legacy way.

> So I decided to handle block data first and bypass the rest
> of the parameter handling code.
> 
> Guenter
> 
> --
> Index: tools/i2cset.c
> ===================================================================
> --- tools/i2cset.c	(revision 5909)
> +++ tools/i2cset.c	(working copy)
> @@ -35,13 +35,15 @@
>  static void help(void)
>  {
>  	fprintf(stderr,
> -	        "Usage: i2cset [-f] [-y] [-m MASK] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] [MODE]\n"
> +	        "Usage: i2cset [-f] [-y] [-m MASK] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] ... [MODE]\n"
>  		"  I2CBUS is an integer or an I2C bus name\n"
>  		"  ADDRESS is an integer (0x03 - 0x77)\n"
>  		"  MODE is one of:\n"
>  		"    c (byte, no value)\n"
>  		"    b (byte data, default)\n"
>  		"    w (word data)\n"
> +		"    i (I2C block data)\n"
> +		"    s (SMBus block data)\n"
>  		"    Append p for SMBus PEC\n");
>  	exit(1);
>  }
> @@ -78,6 +80,19 @@
>  			return -1;
>  		}
>  		break;
> +
> +	case I2C_SMBUS_BLOCK_DATA:
> +		if (!(funcs & I2C_FUNC_SMBUS_READ_BLOCK_DATA)) {
> +			fprintf(stderr, MISSING_FUNC_FMT, "SMBus block read");
> +			return -1;
> +		}
> +		break;
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		if (!(funcs & I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> +			fprintf(stderr, MISSING_FUNC_FMT, "I2C block read");
> +			return -1;
> +		}
> +		break;

Why are you testing READ functionalities when what you want to do is
WRITE?

>  	}
>  
>  	if (pec
> @@ -90,7 +105,7 @@
>  }
>  
>  static int confirm(const char *filename, int address, int size, int daddress,
> -		   int value, int vmask, int pec)
> +		   int value, int vmask, unsigned char *block, int len, int pec)

The block pointer could be const.

>  {
>  	int dont = 0;
>  
> @@ -109,7 +124,16 @@
>  		"0x%02x, data address\n0x%02x, ", filename, address, daddress);
>  	if (size == I2C_SMBUS_BYTE)
>  		fprintf(stderr, "no data.\n");
> -	else
> +	else if (size == I2C_SMBUS_BLOCK_DATA ||
> +		 size == I2C_SMBUS_I2C_BLOCK_DATA) {
> +		int i;
> +
> +		fprintf(stderr, "data");
> +		for (i = 0; i < len; i++)
> +			fprintf(stderr, " 0x%02x", block[i]);
> +		fprintf(stderr, ", mode %s.\n", size == I2C_SMBUS_BLOCK_DATA
> +			? "smbus block" : "i2c block");
> +	} else
>  		fprintf(stderr, "data 0x%02x%s, mode %s.\n", value,
>  			vmask ? " (masked)" : "",
>  			size == I2C_SMBUS_BYTE_DATA ? "byte" : "word");
> @@ -136,6 +160,8 @@
>  	int pec = 0;
>  	int flags = 0;
>  	int force = 0, yes = 0, version = 0, readback = 0;
> +	unsigned char block[32];

It might make sense to use I2C_SMBUS_BLOCK_MAX instead of hard-coding
32?

> +	int len;
>  
>  	/* handle (optional) flags first */
>  	while (1+flags < argc && argv[1+flags][0] == '-') {
> @@ -180,6 +206,30 @@
>  		help();
>  	}
>  
> +	/* check for block data */
> +	len = 0;
> +	if (argc > flags + 5) {

This makes it impossible to write 1-byte blocks, right? This is bad.

> +		switch (argv[argc-1][0]) {
> +		case 's': size = I2C_SMBUS_BLOCK_DATA; break;
> +		case 'i': size = I2C_SMBUS_I2C_BLOCK_DATA; break;
> +		default:
> +			size = 0;
> +			break;
> +		}
> +		if (size == I2C_SMBUS_BLOCK_DATA || size == I2C_SMBUS_I2C_BLOCK_DATA) {
> +			pec = argv[argc-1][1] == 'p';

ip isn't a valid mode. PEC is not defined for non-SMBus transactions
(and despite its name, I2C_SMBUS_I2C_BLOCK_DATA read and writes are not
SMBus transactions.

> +			for (len = 0; len < (int)sizeof(block) && len + flags + 5 < argc; len++) {

Do you actually need the cast?

> +				value = strtol(argv[flags + len + 4], &end, 0);
> +				if (*end || value < 0 || value > 0xff) {
> +                                	fprintf(stderr, "Error: Block data value invalid!\n");
> +                                	help();
> +                        	}
> +				block[len] = value;
> +			}
> +			goto dofile;
> +		}
> +	}
> +
>  	if (argc > flags + 4) {
>  		if (!strcmp(argv[flags+4], "c")
>  		 || !strcmp(argv[flags+4], "cp")) {
> @@ -236,6 +286,7 @@
>  		help();
>  	}
>  
> +dofile:
>  	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
>  	if (file < 0
>  	 || check_funcs(file, size, pec)
> @@ -243,7 +294,7 @@
>  		exit(1);
>  
>  	if (!yes && !confirm(filename, address, size, daddress,
> -			     value, vmask, pec))
> +			     value, vmask, block, len, pec))
>  		exit(0);
>  
>  	if (vmask) {
> @@ -299,11 +350,18 @@
>  	case I2C_SMBUS_WORD_DATA:
>  		res = i2c_smbus_write_word_data(file, daddress, value);
>  		break;
> +	case I2C_SMBUS_BLOCK_DATA:
> +		res = i2c_smbus_write_block_data(file, daddress, len, block);
> +		break;
> +	case I2C_SMBUS_I2C_BLOCK_DATA:
> +		res = i2c_smbus_write_i2c_block_data(file, daddress, len, block);
> +		break;
>  	default: /* I2C_SMBUS_BYTE_DATA */
>  		res = i2c_smbus_write_byte_data(file, daddress, value);
> +		break;
>  	}
>  	if (res < 0) {
> -		fprintf(stderr, "Error: Write failed\n");
> +		perror("Error: Write failed");

Hmm, do i2c_smbus_()* calls actually set errno? I didn't expect them
to. Either way, if this change is wanted, it doesn't belong to this
patch.

>  		close(file);
>  		exit(1);
>  	}

I tested your patch for the I2C block write case, it worked OK.

Please also update the manual page.

-- 
Jean Delvare
