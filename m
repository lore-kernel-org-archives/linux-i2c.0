From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [patch 2.6.25-rc1] i2c: improve smbus-protocol
 documentation
Date: Sat, 10 May 2008 09:25:08 +0200
Message-ID: <20080510092508.6f9bd2d2@hyperion.delvare>
References: <200805031750.34306.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805031750.34306.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi David,

On Sat, 3 May 2008 17:50:33 -0700, David Brownell wrote:
> Improve the smbus-protocol documentation file somewhat:
> 
>  - Use the names of the SMBus protocol operations (from the 2.0
>    specification), not made-up-for-Linux names.
> 
>  - Add the name of the call used to execute each operation ... and
>    point out that there are mismatches, where functions execute
>    different protocol operations than their names specify.
>    
> The most confusing examples are that "Read Byte" isn't executed by
> i2c_smbus_read_byte(), and that "Write Byte" isn't executed by
> i2c_smbus_write_byte().  When coding, that's not as bad as it may
> seem; but that case would seem to be worth fixing.
> 
> Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> ---
> As doc-only, this is appropriate for bundling with any I2C fixes
> before the 2.6.26-final code freeze.  Note that this doesn't address
> the confusion between "command" and "register" in this text, though
> in some cases it reduces confusion between "command" and "protocol
> operation" or "function call".
> 
>  Documentation/i2c/smbus-protocol |   75 +++++++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 33 deletions(-)

Applied, thanks for doing this. This patch will be included in my next
batch to Linus (probably today or tomorrow.)

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
