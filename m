From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] i2c: ocores: Fix pointer to integer cast warning
Date: Tue, 19 Feb 2013 09:31:19 +0100
Message-ID: <87liakiu20.fsf@dell.be.48ers.dk>
References: <1361259199-24709-1-git-send-email-jchandra@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361259199-24709-1-git-send-email-jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
	(Jayachandran C.'s message of "Tue, 19 Feb 2013 13:03:19 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

>>>>> "Jayachandran" == Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> writes:

 Jayachandran> After commit a000b8c1 [i2c: ocores: Add support for the
 Jayachandran> GRLIB port of the controller and use function pointers
 Jayachandran> for getreg and setreg function], compiling i2c-ocores.c
 Jayachandran> for 64-bit gives the following warning:

 Jayachandran>   drivers/i2c/busses/i2c-ocores.c: In function 'ocores_i2c_of_probe':
 Jayachandran>   drivers/i2c/busses/i2c-ocores.c:334:15: warning: cast from pointer to integer of different size

 Jayachandran> Fix it by casting the pointer to long.

I've CC'ed Andreas who made the change.

Acked-by: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>

 Jayachandran> Signed-off-by: Jayachandran C <jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
 Jayachandran> ---
 Jayachandran>  drivers/i2c/busses/i2c-ocores.c |    2 +-
 Jayachandran>  1 file changed, 1 insertion(+), 1 deletion(-)

 Jayachandran> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
 Jayachandran> index a873d0a..6afa02d 100644
 Jayachandran> --- a/drivers/i2c/busses/i2c-ocores.c
 Jayachandran> +++ b/drivers/i2c/busses/i2c-ocores.c
 Jayachandran> @@ -331,7 +331,7 @@ static int ocores_i2c_of_probe(struct platform_device *pdev,
 Jayachandran>  				&i2c->reg_io_width);
 
 Jayachandran>  	match = of_match_node(ocores_i2c_match, pdev->dev.of_node);
 Jayachandran> -	if (match && (int)match->data == TYPE_GRLIB) {
 Jayachandran> +	if (match && (long)match->data == TYPE_GRLIB) {
 Jayachandran>  		dev_dbg(&pdev->dev, "GRLIB variant of i2c-ocores\n");
 i2c-> setreg = oc_setreg_grlib;
 i2c-> getreg = oc_getreg_grlib;
 Jayachandran> -- 
 Jayachandran> 1.7.9.5


 Jayachandran> --
 Jayachandran> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
 Jayachandran> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 Jayachandran> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Bye, Peter Korsgaard
