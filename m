From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: i2ctools/i2cset: Remove obsolete means to specify value mask
Date: Sun, 13 Feb 2011 08:41:41 -0800
Message-ID: <20110213164141.GA13323@ericsson.com>
References: <20110131161945.GA4197@ericsson.com>
 <20110213112305.615c291b@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110213112305.615c291b-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Sun, Feb 13, 2011 at 05:23:05AM -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> Sorry for the late reply.
> 
No problem. I appreciate your feedback.

> On Mon, 31 Jan 2011 08:19:45 -0800, Guenter Roeck wrote:
> > Attached patch removes the obsolete means to specify the value mask from i2cset.
> > It also streamlines and improves parameter validation.
> 
> I'm afraid these are too many changes at once for an easy review. I'll
> try still, but ideally this would have been two patches at least.
> 
No good idea how to split it, though.

> Overall it looks good and I agree the new code is slightly easier to
> follow than the original code. I didn't really have a problem with the
> original code, but my view is certainly biased as I wrote most of it ;)
> 
Another option would be to just keep the original code. This patch doesn't
really change anything from a functionality perspective (other than being
more stringent with parameter checking), and the proposed changes are not
really needed. So I am perfectly fine with dropping it if you think
it isn't worth it.

> I did some tests and did not find any problem.
> 
> > --
> > Index: tools/i2cset.c
> > ===================================================================
> > --- tools/i2cset.c	(revision 5911)
> > +++ tools/i2cset.c	(working copy)
> > @@ -156,7 +156,7 @@
> >  	char *end;
> >  	const char *maskp = NULL;
> >  	int res, i2cbus, address, size, file;
> > -	int value, daddress, vmask = 0;
> > +	int value = -1, daddress, vmask = 0;
> 
> I'd rather move this initialization to where it is needed (the default
> case in the switch block which reads the values from the command line).
> Pre-initializing variables unconditionally to prevent gcc warnings
> voids the value of these warnings.
> 
The compiler does not understand when value is not used when passed to confirm(),
so it will have be initialized all the time, including the BLOCK_DATA case
(because its use there is more of a side effect). I moved the initialization
to the default and to the BLOCK_DATA cases. 

> >  	char filename[20];
> >  	int pec = 0;
> >  	int flags = 0;
> > @@ -207,74 +207,78 @@
> >  		help();
> >  	}
> >  
> > -	/* check for block data */
> >  	len = 0;
> 
> It's confusing why you initialize len here. I think it would make more
> sense to initialize it later, where you set it for block transactions.
> 
The compiler doesn't understand that len is only used for block transactions
in confirm(), and complains about an uninitialized variable otherwise.
So it needs to be initialized for all commands.

Let me know if you have a better idea how to handle this - I don't like it
too much either. For now I just added a comment explaining the reason for
the initialization.

> > -	if (argc > flags + 5) {
> 
> You could add a comment here, saying that you are now checking for the
> mode.
> 
ok

> > +	if (argc == flags + 4) {
> > +		/* Implicit "c" */
> > +		size = I2C_SMBUS_BYTE;
> > +	} else if (argc == flags + 5) {
> > +		/* "c", "cp",  or implicit "b" */
> > +		if (!strcmp(argv[flags+4], "c")
> > +		 || !strcmp(argv[flags+4], "cp")) {
> > +			size = I2C_SMBUS_BYTE;
> > +			pec = argv[flags+4][1] == 'p';
> > +		} else {
> > +			size = I2C_SMBUS_BYTE_DATA;
> > +		}
> > +	} else {
> > +		/* All other commands */
> > +		if (strlen(argv[argc-1]) > 2
> > +		    || (strlen(argv[argc-1]) == 2 && argv[argc-1][1] != 'p')) {
> > +			fprintf(stderr, "Error: Invalid argument '%s'\n", argv[argc-1]);
> > +			help();
> > +		}
> >  		switch (argv[argc-1][0]) {
> > +		case 'b': size = I2C_SMBUS_BYTE_DATA; break;
> > +		case 'w': size = I2C_SMBUS_WORD_DATA; break;
> >  		case 's': size = I2C_SMBUS_BLOCK_DATA; break;
> >  		case 'i': size = I2C_SMBUS_I2C_BLOCK_DATA; break;
> >  		default:
> > -			size = 0;
> > -			break;
> > +			fprintf(stderr, "Error: Invalid argument '%s'\n", argv[argc-1]);
> 
> The original code complained about an "invalid mode", rather than an
> "invalid argument". I think this wording was more helpful, as it tells
> the user what was expected for the argument.
> 
Ok, changed.

> > +			help();
> >  		}
> > +		pec = argv[argc-1][1] == 'p';
> >  		if (size == I2C_SMBUS_BLOCK_DATA || size == I2C_SMBUS_I2C_BLOCK_DATA) {
> > -			pec = argv[argc-1][1] == 'p';
> >  			if (pec && size == I2C_SMBUS_I2C_BLOCK_DATA) {
> >  				fprintf(stderr, "Error: PEC not supported for I2C block writes!\n");
> >  				help();
> >  			}
> > -			for (len = 0; len < (int)sizeof(block) && len + flags + 5 < argc; len++) {
> > -				value = strtol(argv[flags + len + 4], &end, 0);
> > -				if (*end || value < 0 || value > 0xff) {
> > -                                	fprintf(stderr, "Error: Block data value invalid!\n");
> > -                                	help();
> > -                        	}
> > -				block[len] = value;
> > -			}
> > -			goto dofile;
> > -		}
> > -	}
> > -
> > -	if (argc > flags + 4) {
> > -		if (!strcmp(argv[flags+4], "c")
> > -		 || !strcmp(argv[flags+4], "cp")) {
> > -			size = I2C_SMBUS_BYTE;
> > -			value = -1;
> > -			pec = argv[flags+4][1] == 'p';
> > -		} else {
> > -			size = I2C_SMBUS_BYTE_DATA;
> > -			value = strtol(argv[flags+4], &end, 0);
> > -			if (*end || value < 0) {
> > -				fprintf(stderr, "Error: Data value invalid!\n");
> > +			if (maskp) {
> > +				fprintf(stderr, "Error: Mask not supported for block writes!\n");
> >  				help();
> >  			}
> > +		} else if (argc != flags + 6) {
> > +			fprintf(stderr, "Error: Bad number of arguments!\n");
> > +			help();
> >  		}
> > -	} else {
> > -		size = I2C_SMBUS_BYTE;
> > -		value = -1;
> >  	}
> >  
> > -	if (argc > flags + 5) {
> > -		switch (argv[flags+5][0]) {
> > -		case 'b': size = I2C_SMBUS_BYTE_DATA; break;
> > -		case 'w': size = I2C_SMBUS_WORD_DATA; break;
> > -		default:
> > -			fprintf(stderr, "Error: Invalid mode!\n");
> 
> You could add a comment here, saying that you are now reading the
> values from the command line.
> 
ok

> > +	switch(size) {
> 
> Coding style: missing space before opening parenthesis.
> 
ok

> > +	case I2C_SMBUS_BYTE_DATA:
> > +	case I2C_SMBUS_WORD_DATA:
> > +		value = strtol(argv[flags+4], &end, 0);
> > +		if (*end || value < 0) {
> > +			fprintf(stderr, "Error: Data value invalid!\n");
> >  			help();
> >  		}
> > -		pec = argv[flags+5][1] == 'p';
> > -	}
> > -
> > -	/* Old method to provide the value mask, deprecated and no longer
> > -	   documented but still supported for compatibility */
> > -	if (argc > flags + 6) {
> > -		if (maskp) {
> > -			fprintf(stderr, "Error: Data value mask provided twice!\n");
> > +		if ((size == I2C_SMBUS_BYTE_DATA && value > 0xff)
> > +	 	    || (size == I2C_SMBUS_WORD_DATA && value > 0xffff)) {
> > +			fprintf(stderr, "Error: Data value out of range!\n");
> >  			help();
> >  		}
> > -		fprintf(stderr, "Warning: Using deprecated way to set the data value mask!\n");
> > -		fprintf(stderr, "         Please switch to using -m.\n");
> > -		maskp = argv[flags+6];
> > +		break;
> > +	case I2C_SMBUS_BLOCK_DATA:
> > +	case I2C_SMBUS_I2C_BLOCK_DATA:
> > +		for (len = 0; len < (int)sizeof(block) && len + flags + 5 < argc; len++) {
> 
> I think it would make sense to count the values first, and complain if
> there are too many of these. Silently ignoring the extra values isn't
> helpful for the user.
> 
ok

> > +			value = strtol(argv[flags + len + 4], &end, 0);
> > +			if (*end || value < 0 || value > 0xff) {
> > +                               	fprintf(stderr, "Error: Block data value invalid!\n");
> 
> The non-block case has separate error messages for invalid and out of
> range values, we could do the same here for consistency.
> 
ok

> OTOH I don't think it adds value to include "block" in the error
> message, it prevents gcc from reusing the other message and doesn't add
> value.
> 
ok

> > +                               	help();
> > +                       	}
> 
> The indentation of the 3 previous lines is wrong (spaces instead of
> tabs.)
> 
ok

> > +			block[len] = value;
> > +		}
> > +		break;
> > +	default:
> > +		break;
> >  	}
> >  
> >  	if (maskp) {
> > @@ -285,13 +289,6 @@
> >  		}
> >  	}
> >  
> > -	if ((size == I2C_SMBUS_BYTE_DATA && value > 0xff)
> > -	 || (size == I2C_SMBUS_WORD_DATA && value > 0xffff)) {
> > -		fprintf(stderr, "Error: Data value out of range!\n");
> > -		help();
> > -	}
> > -
> > -dofile:
> >  	file = open_i2c_dev(i2cbus, filename, sizeof(filename), 0);
> >  	if (file < 0
> >  	 || check_funcs(file, size, pec)
> > Index: CHANGES
> > ===================================================================
> > --- CHANGES	(revision 5911)
> > +++ CHANGES	(working copy)
> > @@ -4,6 +4,8 @@
> >  SVN
> >    i2c-dev.h: Make value arrays const for block write functions
> >    i2cset: Add support for SMBus and I2C block writes
> > +          Removed obsolete method to specify write mask
> > +          More stringent parameter validation
> >  
> >  3.0.3 (2010-12-12)
> >    Makefile: Let the environment set CC and CFLAGS
> 
> -- 
> Jean Delvare
