From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c-i801: Include <linux/slab.h>
Date: Sun, 12 Dec 2010 09:25:59 +0100
Message-ID: <20101212092559.10f6883e@endymion.delvare>
References: <1292100331.3136.47.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <1292100331.3136.47.camel@localhost>
Sender: linux-alpha-owner@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-alpha@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

On Sat, 11 Dec 2010 20:45:31 +0000, Ben Hutchings wrote:
> Commit 5a0e3ad6af8660be21ca98a971cd00f331318c05 added direct inclusion
> of <linux/slab.h> to those source files that appeared to need it, but
> somehow missed this.

Most probably because the i2c-i801 driver didn't do any memory
allocation until this recent change:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=0cd96eb0a74791cacb27ace902b991cfd0e72abe

> On most architectures <linux/slab.h> is still
> indirectly included, but there are exceptions such as alpha.
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  drivers/i2c/busses/i2c-i801.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
> index 02835ce..7979aef 100644
> --- a/drivers/i2c/busses/i2c-i801.c
> +++ b/drivers/i2c/busses/i2c-i801.c
> @@ -72,6 +72,7 @@
>  #include <linux/acpi.h>
>  #include <linux/io.h>
>  #include <linux/dmi.h>
> +#include <linux/slab.h>
>  
>  /* I801 SMBus address offsets */
>  #define SMBHSTSTS(p)	(0 + (p)->smba)

Applied, thanks.

-- 
Jean Delvare
