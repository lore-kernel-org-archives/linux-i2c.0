From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH 1/1] i2c: i2c-diolan-u2c: different usb endpoints for
 DLN-2-U2C
Date: Sun, 24 Nov 2013 09:18:20 -0800
Message-ID: <529234DC.9030908@roeck-us.net>
References: <1385305043-23626-1-git-send-email-mvogt1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385305043-23626-1-git-send-email-mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Vogt <mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 11/24/2013 06:57 AM, Martin Vogt wrote:
> The previous diolan adapter uses other out/in endpoints than
> the current DLN-2-U2C in compatibility mode.
> They changed from 0x2/0x84 to 0x3/0x83.
> This patch gets the endpoints from the usb interface, instead
> of hardcode them in the driver.
>
> This was tested on a current DLN-2-U2C board.
>
> Signed-off-by: Martin Vogt <mvogt1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Reviewed-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
