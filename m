From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: fix docbook problem
Date: Thu, 20 Mar 2008 21:14:50 +0100
Message-ID: <20080320211450.62799973@hyperion.delvare>
References: <20080318151259.49009828.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080318151259.49009828.randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Randy,

On Tue, 18 Mar 2008 15:12:59 -0700, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> 
> Sometimes kernel-doc and xmlto conspire to create output that is invalid
> and causes problems.  Until I know a real/better solution, change the
> source code that causes this.
> 
> If anyone has better fixes or can just explain what is happening here,
> that would be great.

Would be nice, yes.

> 
> xmlto: input does not validate (status 1)
> mmotm-2008-0314-1449/Documentation/DocBook/kernel-api.xml:71468: parser error : Opening and ending tag mismatch: programlisting line 71464 and para
>    </para><para>
>           ^
> mmotm-2008-0314-1449/Documentation/DocBook/kernel-api.xml:71480: parser error : Opening and ending tag mismatch: para line 71473 and programlisting
> </programlisting></informalexample>
>                  ^
> make[1]: *** [Documentation/DocBook/kernel-api.html] Error 1
> 
> Signed-off-by: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/i2c/i2c-core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- mmotm-2008-0314-1449.orig/drivers/i2c/i2c-core.c
> +++ mmotm-2008-0314-1449/drivers/i2c/i2c-core.c
> @@ -489,8 +489,8 @@ EXPORT_SYMBOL(i2c_add_adapter);
>   * Context: can sleep
>   *
>   * This routine is used to declare an I2C adapter when its bus number
> - * matters.  Example: for I2C adapters from system-on-chip CPUs, or
> - * otherwise built in to the system's mainboard, and where i2c_board_info
> + * matters.  For example, use it for I2C adapters from system-on-chip CPUs,
> + * or otherwise built in to the system's mainboard, and where i2c_board_info
>   * is used to properly configure I2C devices.
>   *
>   * If no devices have pre-been declared for this bus, then be sure to

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
