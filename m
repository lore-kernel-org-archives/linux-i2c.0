From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] i2c: busses: ali1563: fix checkpatch.pl issues
Date: Fri, 11 Apr 2014 11:21:56 +0200
Message-ID: <20140411112156.5e7e32c2@endymion.delvare>
References: <1397150924-7260-1-git-send-email-me@g0hl1n.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397150924-7260-1-git-send-email-me@g0hl1n.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Leitner <me@g0hl1n.net>
Cc: r.marek@assembler.cz, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Richard,

On Thu, 10 Apr 2014 19:28:44 +0200, Richard Leitner wrote:
> Fixed most checkpatch.pl issues

Thanks for doing this. Overall it looks good, there are just two
warnings I would like fixed slightly differently:

> @@ -268,13 +272,14 @@ static s32 ali1563_access(struct i2c_adapter * a, u16 addr,
>  	}
>  
>  	outb_p(((addr & 0x7f) << 1) | (rw & 0x01), SMB_HST_ADD);
> -	outb_p((inb_p(SMB_HST_CNTL2) & ~HST_CNTL2_SIZEMASK) | (size << 3), SMB_HST_CNTL2);
> +	outb_p((inb_p(SMB_HST_CNTL2) & ~HST_CNTL2_SIZEMASK) |
> +			(size << 3), SMB_HST_CNTL2);

Please align on the opening parenthesis.

> @@ -392,14 +398,15 @@ static struct i2c_adapter ali1563_adapter = {
>  static int ali1563_probe(struct pci_dev *dev,
>  			 const struct pci_device_id *id_table)
>  {
> -	int error;
> +	int error = ali1563_setup(dev);
>  
> -	if ((error = ali1563_setup(dev)))
> +	if (error)
>  		goto exit;

Please leave the variable declaration alone, so that the error check
can immediately follow the assignment, as was the case before. Anyway
it is not recommended to run "real code" during variable declaration.

With these changes applied, feel free to add:

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support
