From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: boilerplate function for byte swapped
 smbus_write/read_word_data
Date: Mon, 10 Oct 2011 13:50:14 +0200
Message-ID: <20111010135014.72598737@endymion.delvare>
References: <20111009094118.44b616bf@endymion.delvare>
	<1318237663-13937-2-git-send-email-jic23@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1318237663-13937-2-git-send-email-jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 10 Oct 2011 10:07:43 +0100, Jonathan Cameron wrote:
> Reimplemented at least 17 times discounting error mangling cases
> where it could be used.
> 
> Signed-off-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> ---
>  Documentation/i2c/smbus-protocol |    8 ++++++++
>  include/linux/i2c.h              |   17 +++++++++++++++++
>  2 files changed, 25 insertions(+), 0 deletions(-)

Applied, thanks.

-- 
Jean Delvare
