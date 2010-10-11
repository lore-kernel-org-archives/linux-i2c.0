From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCHv3 1/5] misc: Driver for bh1770glc / sfh7770 ALS and proximity
 sensor
Date: Mon, 11 Oct 2010 14:43:22 +0100
Message-ID: <4CB3147A.1050103@cam.ac.uk>
References: <1286795209-12487-1-git-send-email-samu.p.onkalo@nokia.com> <1286795209-12487-2-git-send-email-samu.p.onkalo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1286795209-12487-2-git-send-email-samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10/11/10 12:06, Samu Onkalo wrote:
> This is a driver for ROHM BH1770GLC and OSRAM SFH7770 combined
> ALS and proximity sensor.
> 
> Interface is sysfs based. The driver uses interrupts to provide new data.
> The driver supports pm_runtime and regulator frameworks.
> 
> See Documentation/misc-devices/bh1770glc.txt for details
> 
> Signed-off-by: Samu Onkalo <samu.p.onkalo-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Acked-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
> ---
>  drivers/misc/bh1770glc.c      | 1413 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/i2c/bh1770glc.h |   53 ++
>  2 files changed, 1466 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/misc/bh1770glc.c
...
