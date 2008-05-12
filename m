From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c: Add Intel SCH I2C SMBus support
Date: Mon, 12 May 2008 21:40:04 +0200
Message-ID: <20080512214004.6db3375d@hyperion.delvare>
References: <20080424100510.09cc2d4b@dxy.sh.intel.com>
	<48124673.8020808@assembler.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48124673.8020808-/xGekIyIa4Ap1Coe8Ar9gA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 25 Apr 2008 23:00:35 +0200, Rudolf Marek wrote:
> > +/* SCH SMBus address offsets */
> > +#define SMBHSTCNT      (0 + sch_smba)
> > +#define SMBHSTSTS      (1 + sch_smba)
> > +#define SMBHSTADD      (4 + sch_smba) /* TSA */
> > +#define SMBHSTCMD      (5 + sch_smba)
> > +#define SMBHSTDAT0     (6 + sch_smba)
> > +#define SMBHSTDAT1     (7 + sch_smba)
> > +#define SMBBLKDAT      (0x20 + sch_smba)
> > +
> > +
> > +/* count for request_region */
> > +#define SMBIOSIZE      8
> 
> No it is 64 bytes

The datasheet has contradictions. It says 32 bytes in section 5.4.2,
table 13. But it says 64 bytes in section 17.3.1. Given that the block
registers span from offset 32 to offset 63, the latter is obviously
correct.

Alek, can you please have table 13 fixed in the datasheet?

-- 
Jean Delvare

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
