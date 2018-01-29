From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 2/3] Update help message for risky_addr option
Date: Mon, 29 Jan 2018 14:45:40 +0100
Message-ID: <c16bd2a4-f4bf-43ec-5429-5b01966b1e4c@axentia.se>
References: <20180105150248.3170-1-romain.porte@nokia.com>
 <20180129124010.4044-1-romain.porte@nokia.com>
 <20180129124010.4044-3-romain.porte@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-db5eur01on0101.outbound.protection.outlook.com ([104.47.2.101]:2092
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751298AbeA2Nps (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Mon, 29 Jan 2018 08:45:48 -0500
In-Reply-To: <20180129124010.4044-3-romain.porte@nokia.com>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Romain Porte <romain.porte@nokia.com>, wsa@the-dreams.de
Cc: jdelvare@suse.de, linux-i2c@vger.kernel.org

On 2018-01-29 13:40, Romain Porte wrote:
> Add [-a] option to short help message of i2c tools. This is the option
> that the user needs to activate for using the risky_addr feature.
> 
> Signed-off-by: Romain Porte <romain.porte@nokia.com>
> ---
>  tools/i2cdump.c     | 2 +-
>  tools/i2cget.c      | 2 +-
>  tools/i2cset.c      | 2 +-
>  tools/i2ctransfer.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/i2cdump.c b/tools/i2cdump.c
> index be0d93f..733edaa 100644
> --- a/tools/i2cdump.c
> +++ b/tools/i2cdump.c
> @@ -36,7 +36,7 @@
>  static void help(void)
>  {
>  	fprintf(stderr,
> -		"Usage: i2cdump [-f] [-y] [-r first-last] I2CBUS ADDRESS [MODE [BANK [BANKREG]]]\n"
> +		"Usage: i2cdump [-f] [-y] [-r first-last] [-a] I2CBUS ADDRESS [MODE [BANK [BANKREG]]]\n"
>  		"  I2CBUS is an integer or an I2C bus name\n"
>  		"  ADDRESS is an integer (0x03 - 0x77)\n"

This is no longer entirely true; you might want to squeeze in something
about -a here. E.g.

		"  ADDRESS is an integer (0x03 - 0x77, or 0x00 - 0x7f if -a is given)\n"

And below for the other instances of course...

Cheers,
Peter

>  		"  MODE is one of:\n"
> diff --git a/tools/i2cget.c b/tools/i2cget.c
> index acc5236..6660991 100644
> --- a/tools/i2cget.c
> +++ b/tools/i2cget.c
> @@ -41,7 +41,7 @@ static void help(void) __attribute__ ((noreturn));
>  static void help(void)
>  {
>  	fprintf(stderr,
> -		"Usage: i2cget [-f] [-y] I2CBUS CHIP-ADDRESS [DATA-ADDRESS [MODE]]\n"
> +		"Usage: i2cget [-f] [-y] [-a] I2CBUS CHIP-ADDRESS [DATA-ADDRESS [MODE]]\n"
>  		"  I2CBUS is an integer or an I2C bus name\n"
>  		"  ADDRESS is an integer (0x03 - 0x77)\n"
>  		"  MODE is one of:\n"
> diff --git a/tools/i2cset.c b/tools/i2cset.c
> index 87c8cf3..5c3d6d7 100644
> --- a/tools/i2cset.c
> +++ b/tools/i2cset.c
> @@ -38,7 +38,7 @@ static void help(void) __attribute__ ((noreturn));
>  static void help(void)
>  {
>  	fprintf(stderr,
> -		"Usage: i2cset [-f] [-y] [-m MASK] [-r] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] ... [MODE]\n"
> +		"Usage: i2cset [-f] [-y] [-m MASK] [-r] [-a] I2CBUS CHIP-ADDRESS DATA-ADDRESS [VALUE] ... [MODE]\n"
>  		"  I2CBUS is an integer or an I2C bus name\n"
>  		"  ADDRESS is an integer (0x03 - 0x77)\n"
>  		"  MODE is one of:\n"
> diff --git a/tools/i2ctransfer.c b/tools/i2ctransfer.c
> index e6e9f0a..256fca7 100644
> --- a/tools/i2ctransfer.c
> +++ b/tools/i2ctransfer.c
> @@ -42,7 +42,7 @@ enum parse_state {
>  static void help(void)
>  {
>  	fprintf(stderr,
> -		"Usage: i2ctransfer [-f] [-y] [-v] [-V] I2CBUS DESC [DATA] [DESC [DATA]]...\n"
> +		"Usage: i2ctransfer [-f] [-y] [-v] [-V] [-a] I2CBUS DESC [DATA] [DESC [DATA]]...\n"
>  		"  I2CBUS is an integer or an I2C bus name\n"
>  		"  DESC describes the transfer in the form: {r|w}LENGTH[@address]\n"
>  		"    1) read/write-flag 2) LENGTH (range 0-65535) 3) I2C address (use last one if omitted)\n"
> 
