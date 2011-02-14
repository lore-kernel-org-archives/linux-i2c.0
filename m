From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 2/6] i2cset: Check number of arguments for block data
 writes
Date: Mon, 14 Feb 2011 09:52:16 +0100
Message-ID: <20110214095216.7ba055fa@endymion.delvare>
References: <1297628246-19367-1-git-send-email-guenter.roeck@ericsson.com>
	<1297628246-19367-3-git-send-email-guenter.roeck@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297628246-19367-3-git-send-email-guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, 13 Feb 2011 12:17:22 -0800, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
> ---
>  tools/i2cset.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/tools/i2cset.c b/tools/i2cset.c
> index 8856d71..c59186b 100644
> --- a/tools/i2cset.c
> +++ b/tools/i2cset.c
> @@ -219,11 +219,15 @@ int main(int argc, char *argv[])
>  		}
>  		if (size == I2C_SMBUS_BLOCK_DATA || size == I2C_SMBUS_I2C_BLOCK_DATA) {
>  			pec = argv[argc-1][1] == 'p';
> +			if (argc > (int)sizeof(block) + flags + 5) {
> +				fprintf(stderr, "Error: Bad number of arguments!\n");
> +				help();
> +			}
>  			if (pec && size == I2C_SMBUS_I2C_BLOCK_DATA) {
>  				fprintf(stderr, "Error: PEC not supported for I2C block writes!\n");
>  				help();
>  			}

It would probably be more logical to swap the two blocks above, as you
set pec just before and are reading the arguments just after.

> -			for (len = 0; len < (int)sizeof(block) && len + flags + 5 < argc; len++) {
> +			for (len = 0; len + flags + 5 < argc; len++) {
>  				value = strtol(argv[flags + len + 4], &end, 0);
>  				if (*end || value < 0 || value > 0xff) {
>                                  	fprintf(stderr, "Error: Block data value invalid!\n");

Other than this, it looks good.

-- 
Jean Delvare
