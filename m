From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 042/199] Documentation/i2c/busses/i2c-ali1535:
 Checkpatch cleanup
Date: Sun, 23 May 2010 23:14:55 +0200
Message-ID: <20100523231455.74927a98@hyperion.delvare>
References: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
	<1274644605-25181-14-git-send-email-andrea.gelmini@gelma.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1274644605-25181-14-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Randy Dunlap <rdunlap@xenotime.net>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Andrea,

On Sun, 23 May 2010 21:56:10 +0200, Andrea Gelmini wrote:
> Documentation/i2c/busses/i2c-ali1535:9: ERROR: trailing whitespace
> Documentation/i2c/busses/i2c-ali1535:14: ERROR: trailing whitespace
> 
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>  Documentation/i2c/busses/i2c-ali1535 |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/i2c/busses/i2c-ali1535 b/Documentation/i2c/busses/i2c-ali1535
> index 0db3b4c..acbc65a 100644
> --- a/Documentation/i2c/busses/i2c-ali1535
> +++ b/Documentation/i2c/busses/i2c-ali1535
> @@ -6,12 +6,12 @@ Supported adapters:
>  	http://www.ali.com.tw/eng/support/datasheet_request.php
>  
>  Authors:
> -	Frodo Looijaard <frodol@dds.nl>, 
> +	Frodo Looijaard <frodol@dds.nl>,
>  	Philip Edelbrock <phil@netroedge.com>,
>  	Mark D. Studebaker <mdsxyz123@yahoo.com>,
>  	Dan Eaton <dan.eaton@rocketlogix.com>,
>  	Stephen Rousset<stephen.rousset@rocketlogix.com>
> -												
> +
>  Description
>  -----------
>  

For such a trivial change, I definitely prefer a single patch for all
files. I'll merge them all and apply the result.

Thanks,
-- 
Jean Delvare
