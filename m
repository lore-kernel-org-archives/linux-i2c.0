From: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] NFC: Driver for Inside Secure MicroRead NFC chip
Date: Fri, 18 Mar 2011 08:50:33 -0700
Message-ID: <20110318085033.9bea6dc9.rdunlap@xenotime.net>
References: <1300444824-13713-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
	<1300444824-13713-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1300444824-13713-2-git-send-email-waldemar.rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Waldemar Rymarkiewicz <waldemar.rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hthebaud-Umy9UjvE/gtWk0Htik3J/w@public.gmane.org, matti.j.aaltonen-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 18 Mar 2011 11:40:24 +0100 Waldemar Rymarkiewicz wrote:

> Add new driver for MicroRead NFC chip connected to i2c bus.
> 
> See Documentation/nfc/nfc-microread.txt.
> 
> Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/nfc/nfc-microread.txt |   46 ++++
>  drivers/nfc/Kconfig                 |   10 +
>  drivers/nfc/Makefile                |    1 +
>  drivers/nfc/microread.c             |  465 +++++++++++++++++++++++++++++++++++
>  include/linux/nfc/microread.h       |   31 +++
>  5 files changed, 553 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/nfc/nfc-microread.txt
>  create mode 100644 drivers/nfc/microread.c
>  create mode 100644 include/linux/nfc/microread.h
> 
> diff --git a/Documentation/nfc/nfc-microread.txt b/Documentation/nfc/nfc-microread.txt
> new file mode 100644
> index 0000000..e15c49c
> --- /dev/null
> +++ b/Documentation/nfc/nfc-microread.txt
> @@ -0,0 +1,46 @@
> +Kernel driver for Inside Secure MicroRead Near Field Communication chip
> +
> +General
> +-------
> +
> +microread is the RF chip that uses Near Field Communication (NFC) for proximity
> +transactions and interactions.
> +
> +Please visit Inside Secure webside for microread specification:

                              website (or web site)

> +http://www.insidesecure.com/eng/Products/NFC-Products/MicroRead
> +
> +
> +The Driver
> +----------
> +
> +The microread driver can be found under drivers/nfc/microread.c and it's
> +compiled as a module named "microread".
> +
> +The driver supports i2c interface only.
> +
> +The userspace application can use /dev/microread device to control the chip by
> +HCI messages. In a typical scenario application will open() /dev/microread,
> +reset the chip useing ioctl() interface then poll() the device to check if

                  using

> +writing/reaing is possible.Finally, will read/write data (HCI) from/to the chip.

           reading is possible. Finally, it will

> +
> +Note that only one application can use the /dev/microread at the time.
> +
> +The driver waits for microread chip interrupt which occures if there are some

                                                       occurs

> +data to be read. Then, poll() will indicate that fact to the userspace.
> +
> +The application can use ioctl(MICROREAD_IOC_RESET)to reset the hardware.

                                              _RESET) to reset

> +
> +
> +Platform Data
> +-------------
> +
> +The below platform data should be set when configuring board.
> +
> +struct microread_nfc_platform_data {
> +	unsigned int rst_gpio;
> +	unsigned int irq_gpio;
> +	unsigned int ioh_gpio;
> +	int (*request_hardware) (struct i2c_client *client);
> +	void (*release_hardware) (void);
> +};
> +


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
