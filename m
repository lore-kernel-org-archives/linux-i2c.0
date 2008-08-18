From: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: i2c kernel-doc warnings
Date: Mon, 18 Aug 2008 14:08:13 -0700
Message-ID: <20080818140813.5b3d4102.rdunlap@xenotime.net>
References: <20080721102454.0ffe7631.rdunlap@xenotime.net>
	<20080818223609.7b570357@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080818223609.7b570357-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, Linux I2C <i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 18 Aug 2008 22:36:09 +0200 Jean Delvare wrote:

> Hi Randy,
> 
> On Mon, 21 Jul 2008 10:24:54 -0700, Randy Dunlap wrote:
> > Hi Jean,
> > 
> > Can you try to have someone fix these, please?
> > 
> > Warning(/local/linsrc/repo/linhead//include/linux/i2c.h:169): No description found for parameter 'id'
> > Warning(/local/linsrc/repo/linhead//include/linux/i2c.h:169): No description found for parameter 'attach_adapter'
> > Warning(/local/linsrc/repo/linhead//include/linux/i2c.h:169): No description found for parameter 'detach_adapter'
> > Warning(/local/linsrc/repo/linhead//include/linux/i2c.h:169): No description found for parameter 'detach_client'
> > Warning(/local/linsrc/repo/linhead//include/linux/i2c.h:169): No description found for parameter 'probe'
> > Warning(/local/linsrc/repo/linhead//include/linux/i2c.h:169): No description found for parameter 'remove'
> > Warning(/local/linsrc/repo/linhead//include/linux/i2c.h:169): No description found for parameter 'shutdown'
> > Warning(/local/linsrc/repo/linhead//include/linux/i2c.h:169): No description found for parameter 'suspend'
> > Warning(/local/linsrc/repo/linhead//include/linux/i2c.h:169): No description found for parameter 'resume'
> > Warning(/local/linsrc/repo/linhead//include/linux/i2c.h:169): No description found for parameter 'command'
> > Warning(/local/linsrc/repo/linhead//include/linux/i2c.h:169): No description found for parameter 'driver'
> > Warning(/local/linsrc/repo/linhead//include/linux/i2c.h:169): No description found for parameter 'id_table'
> 
> Something like this?

Yes, that's good.  Thanks.

Acked-by: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>


> Add missing kernel descriptions of struct i2c_driver members.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Randy Dunlap <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
> Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> ---
>  include/linux/i2c.h |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> --- linux-2.6.27-rc3.orig/include/linux/i2c.h	2008-08-05 18:18:01.000000000 +0200
> +++ linux-2.6.27-rc3/include/linux/i2c.h	2008-08-18 22:33:51.000000000 +0200
> @@ -97,7 +97,19 @@ extern s32 i2c_smbus_write_i2c_block_dat
>  
>  /**
>   * struct i2c_driver - represent an I2C device driver
> + * @id: Unique driver ID (optional)
>   * @class: What kind of i2c device we instantiate (for detect)
> + * @attach_adapter: Callback for bus addition (for legacy drivers)
> + * @detach_adapter: Callback for bus removal (for legacy drivers)
> + * @detach_client: Callback for device removal (for legacy drivers)
> + * @probe: Callback for device binding (new-style drivers)
> + * @remove: Callback for device unbinding (new-style drivers)
> + * @shutdown: Callback for device shutdown
> + * @suspend: Callback for device suspend
> + * @resume: Callback for device resume
> + * @command: Callback for bus-wide signaling (optional)
> + * @driver: Device driver model driver
> + * @id_table: List of I2C devices supported by this driver
>   * @detect: Callback for device detection
>   * @address_data: The I2C addresses to probe, ignore or force (for detect)
>   * @clients: List of detected clients we created (for i2c-core use only)


---
~Randy
Linux Plumbers Conference, 17-19 September 2008, Portland, Oregon USA
http://linuxplumbersconf.org/

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
