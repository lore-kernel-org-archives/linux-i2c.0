From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 13/14] HID: i2c-hid: also call i2c_hid_free_buffers in
 i2c_hid_remove
Date: Wed, 5 Dec 2012 11:27:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1212051127060.17055@pobox.suse.cz>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com> <1354634875-5182-14-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1354634875-5182-14-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, 4 Dec 2012, Benjamin Tissoires wrote:

> In the case where the hid driver in charge of handling the hid part
> of the device (hid-generic for instance) fails at probe, neither
> i2c_hid_start nor i2c_hid_stop are called.
> Thus, the buffers allocated in i2c_hid_probe are never freed.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index bea4b13..62988f1 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -891,6 +891,9 @@ static int __devexit i2c_hid_remove(struct i2c_client *client)
>  
>  	free_irq(client->irq, ihid);
>  
> +	if (ihid->bufsize)
> +		i2c_hid_free_buffers(ihid);
> +
>  	kfree(ihid);

Applied.

-- 
Jiri Kosina
SUSE Labs
