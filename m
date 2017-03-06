From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [i2c-tools PATCH v2] i2ctransfer: add new tool
Date: Mon, 6 Mar 2017 20:50:38 +0100
Message-ID: <20170306195038.6d6a5y5luyuuy7jv@pengutronix.de>
References: <20170306142931.10457-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40183 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752950AbdCFU1Z (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 6 Mar 2017 15:27:25 -0500
Content-Disposition: inline
In-Reply-To: <20170306142931.10457-1-wsa@the-dreams.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.de>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Hey Wolfram,

On Mon, Mar 06, 2017 at 03:29:31PM +0100, Wolfram Sang wrote:
> Soooo, finally, finally, here is another version of my 'i2ctransfer' tool. This
> time, I'll keep at it until it is upstream. It was lying around long enough.
> Thanks must go to Renesas for further funding this work! Kudos.

\o/

> [...]
> diff --git a/tools/i2ctransfer.8 b/tools/i2ctransfer.8
> new file mode 100644
> index 0000000..f6fb94a
> --- /dev/null
> +++ b/tools/i2ctransfer.8
> @@ -0,0 +1,153 @@
> +.TH i2ctransfer 8 "February 2017"
> +.SH "NAME"
> +i2ctransfer \- send user-defined I2C messages in one transfer
> +
> +.SH SYNOPSIS
> +.B i2ctransfer
> +.RB [ -f ]
> +.RB [ -y ]
> +.RB [ -v ]
> +.I i2cbus desc
> +.RI [ data ]
> +.RI [ desc
> +.RI [ data ]]

You could join the previous two lines.

> +.RI ...
> +.br
> +.B i2ctransfer
> +.B -V
> +
> +.SH DESCRIPTION
> +.B i2ctransfer
> +is a program to create I2C messages and send them combined as one transfer.
> +For read messages, the contents of the received buffers are printed to stdout, one line per read message.
> +.br
> +Please note the difference between a
> +.I transfer
> +and a
> +.I message
> +here.
> +A transfer may consist of multiple messages and is started with a START condition and ends with a STOP condition as described in the I2C specification.
> +Messages within the transfer are concatenated using the REPEATED START condition which is described there as well.
> +Some devices keep their internal states for REPEATED START but reset them after a STOP.
> +Also, you cannot be interrupted by another I2C master during one transfer, but it might happen between multiple transfers.

Well, unless you loose arbitration. Maybe this is too picky to be
relevant here?
Also in single-master setups you can be interrupted if a driver chooses
to start sending a transfer between two of yours. I think this is the
more relevant reason you want to use a single transfer.

> +This programm helps you to create proper transfers for your needs.
> [...]
> diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
> new file mode 100644
> index 0000000..e8ff4be
> --- /dev/null
> +++ b/tools/i2ctransfer.c
> @@ -0,0 +1,347 @@
> [...]
> +static int check_funcs(int file)
> +{
> +	unsigned long funcs;
> +
> +	/* check adapter functionality */
> +	if (ioctl(file, I2C_FUNCS, &funcs) < 0) {
> +		fprintf(stderr, "Error: Could not get the adapter "
> +			"functionality matrix: %s\n", strerror(errno));
> +		return -1;
> +	}
> +
> +	if (!(funcs & I2C_FUNC_I2C)) {
> +		fprintf(stderr, MISSING_FUNC_FMT, "I2C transfers");
> +		return -1;
> +	}

Do you need this check? I hope the kernel doesn't rely on userspace to
not send a transfer the adapter doesn't support? If the kernel checks
appropriatly it's a waste of time to duplicate the check in i2ctransfer?

> +	return 0;
> +}
> +
> +static void print_msgs(struct i2c_msg *msgs, __u32 nmsgs, unsigned flags)
> +{
> +	FILE *output = flags & PRINT_STDERR ? stderr : stdout;
> +	unsigned i;
> +	__u16 j;
> +
> +	for (i = 0; i < nmsgs; i++) {
> +		int read = msgs[i].flags & I2C_M_RD;
> +		int print_buf = (read && (flags & PRINT_READ_BUF)) ||
> +				(!read && (flags & PRINT_WRITE_BUF));
> +
> +		if (flags & PRINT_HEADER)
> +			fprintf(output, "msg %u: addr 0x%02x, %s, len %u",
> +				i, msgs[i].addr, read ? "read" : "write", msgs[i].len);
> +
> +		if (msgs[i].len && print_buf) {
> +			if (flags & PRINT_HEADER)
> +				fprintf(output, ", buf ");
> +			for (j = 0; j < msgs[i].len - 1; j++)
> +				fprintf(output, "0x%02x ", msgs[i].buf[j]);
> +			/* Print final byte with newline */
> +			fprintf(output, "0x%02x\n", msgs[i].buf[j]);
> +		} else if (flags & PRINT_HEADER) {
> +			fprintf(output, "\n");
> +		}
> +	}
> +}
> +
> +static int confirm(const char *filename, struct i2c_msg *msgs, __u32 nmsgs)
> +{
> +	fprintf(stderr, "WARNING! This program can confuse your I2C bus, cause data loss and worse!\n");

Does it kill kittens? :-)

> +	fprintf(stderr, "I will send the following messages to device file %s:\n", filename);
> +	print_msgs(msgs, nmsgs, PRINT_STDERR | PRINT_HEADER | PRINT_WRITE_BUF);
> +
> +	fprintf(stderr, "Continue? [y/N] ");
> +	fflush(stderr);
> +	if (!user_ack(0)) {
> +		fprintf(stderr, "Aborting on user request.\n");
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	char filename[20];
> +	int i2cbus, address = -1, file, arg_idx = 1, nmsgs = 0, nmsgs_sent, i;
> +	int force = 0, yes = 0, version = 0, verbose = 0;
> +	struct i2c_msg msgs[I2C_RDRW_IOCTL_MAX_MSGS];

Should this limit be described in the man page?

> +		switch (state) {
> +		case PARSE_GET_DESC:
> +			flags = 0;
> +
> +			switch (*arg_ptr++) {
> +			case 'r': flags |= I2C_M_RD; break;

This doesn't match kernel coding style and I'd put it on separate lines.

> +			case 'w': break;
> +[...]
> +	close(file);
> +
> +	for (i = 0; i < nmsgs; i++)
> +		free(msgs[i].buf);
> +
> +	exit(0);

return EXIT_SUCCESS; ?

> +
> + err_out_with_arg:
> +	fprintf(stderr, "Error: faulty argument is '%s'\n", argv[arg_idx]);
> + err_out:
> +	close(file);
> +
> +	for (i = 0; i <= nmsgs; i++)
> +		free(msgs[i].buf);
> +
> +	exit(1);

return EXIT_FAILURE; ?

Apart from the exit code this is exactly the trailer of the good path,
so these could share code.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
