From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] EG20T: Update PCH_I2C driver to 2.6.36
Date: Tue, 9 Nov 2010 09:29:44 +0100
Message-ID: <20101109092944.0670d428@endymion.delvare>
References: <4CD8CD32.5000909@dsn.okisemi.com>
	<D5AB6E638E5A3E4B8F4406B113A5A19A3012F51E@shsmsx501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <D5AB6E638E5A3E4B8F4406B113A5A19A3012F51E-QQHDSDV1ERZpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Wang, Qi" <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: "Khor, Andrew Chih Howe" <andrew.chih.howe.khor-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Wang, Yong Y" <yong.y.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Ewe, Kok Howg" <kok.howg.ewe-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Qi, Tomoya,

On Tue, 9 Nov 2010 13:21:11 +0800, Wang, Qi wrote:
> Hi Jean,
>=20
> I verified this driver at our development board, and it passed our te=
st programming. There's no functionality issue now. Also we together po=
lish this code again.
>=20
> Would you please accept this driver?

As you put this driver in the "embedded" section of the menu, I'd
rather leave it to Ben Dooks to pick it. Ben?

>=20
> Best Regards,
> Qi.
>=20
> > -----Original Message-----
> > From: Tomoya MORINAGA [mailto:tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org]
> > Sent: Tuesday, November 09, 2010 12:25 PM
> > To: Jean Delvare (PC drivers, core); Ben Dooks (embedded platforms)=
; Samuel
> > Ortiz; Linus Walleij; Wolfram Sang; Ralf Baechle; srinidhi kasagar;
> > linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: Wang, Qi; Khor, Andrew Chih Howe; Wang, Yong Y; Ewe, Kok Howg
> > Subject: [PATCH] EG20T: Update PCH_I2C driver to 2.6.36
> >
> > Hi Jean,
> >
> > I have got Intel's signature.
> > Please push it to kernel tree.
> >
> > Thanks,
> > Tomoya MORINAGA(OKI SEMICONDUCTOR CO., LTD.)
> > ---
> > I2C driver of EG20T PCH
> >
> > EG20T PCH is the platform controller hub that is going to be used i=
n
> > Intel's upcoming general embedded platform. All IO peripherals in
> > EG20T PCH are actually devices sitting on AMBA bus.
> > EG20T PCH has I2C I/F. Using this I/F, it is able to access system
> > devices connected to I2C.
> >
> > Signed-off-by: Tomoya MORINAGA <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>
> > Reviewed-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
> > Signed-off-by: Qi Wang <qi.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/i2c/busses/Kconfig     |    8 +
> >  drivers/i2c/busses/Makefile    |    1 +
> >  drivers/i2c/busses/i2c-eg20t.c |  900
> > ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 909 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/i2c/busses/i2c-eg20t.c
> >
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfi=
g
> > index 6539ac2..fcce69c 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -627,6 +627,14 @@ config I2C_XILINX
> >         This driver can also be built as a module.  If so, the modu=
le
> >         will be called xilinx_i2c.
> >
> > +config I2C_EG20T
> > +        tristate "PCH I2C of Intel EG20T"
> > +        depends on PCI
> > +        help
> > +          This driver is for PCH(Platform controller Hub) I2C of E=
G20T which
> > +          is an IOH(Input/Output Hub) for x86 embedded processor.
> > +          This driver can access PCH I2C bus device.
> > +
> >  comment "External I2C/SMBus adapter drivers"
> >
> >  config I2C_PARPORT
> > diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makef=
ile
> > index c3ef492..e55e051 100644
> > --- a/drivers/i2c/busses/Makefile
> > +++ b/drivers/i2c/busses/Makefile
> > @@ -60,6 +60,7 @@ obj-$(CONFIG_I2C_STU300)    +=3D i2c-stu300.o
> >  obj-$(CONFIG_I2C_VERSATILE)  +=3D i2c-versatile.o
> >  obj-$(CONFIG_I2C_OCTEON)     +=3D i2c-octeon.o
> >  obj-$(CONFIG_I2C_XILINX)     +=3D i2c-xiic.o
> > +obj-$(CONFIG_I2C_EG20T)         +=3D i2c-eg20t.o
> >
> >  # External I2C/SMBus adapter drivers
> >  obj-$(CONFIG_I2C_PARPORT)    +=3D i2c-parport.o
> > diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2=
c-eg20t.c
> > new file mode 100644
> > index 0000000..f835635
> > --- /dev/null
> > +++ b/drivers/i2c/busses/i2c-eg20t.c
> > @@ -0,0 +1,900 @@
> > +/*
> > + * Copyright (C) 2010 OKI SEMICONDUCTOR CO., LTD.
> > + *
> > + * This program is free software; you can redistribute it and/or m=
odify
> > + * it under the terms of the GNU General Public License as publish=
ed by
> > + * the Free Software Foundation; version 2 of the License.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public Licen=
se
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111=
-1307,
> > USA.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/delay.h>
> > +#include <linux/init.h>
> > +#include <linux/errno.h>
> > +#include <linux/i2c.h>
> > +#include <linux/fs.h>
> > +#include <linux/io.h>
> > +#include <linux/types.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/pci.h>
> > +#include <linux/mutex.h>
> > +#include <linux/ktime.h>
> > +
> > +#define PCH_EVENT_SET        0       /* I2C Interrupt Event Set St=
atus */
> > +#define PCH_EVENT_NONE       1       /* I2C Interrupt Event Clear =
Status */
> > +#define PCH_MAX_CLK          100000  /* Maximum Clock speed in MHz=
 */
> > +#define PCH_BUFFER_MODE_ENABLE       0x0002  /* flag for Buffer mo=
de
> > enable */
> > +#define PCH_EEPROM_SW_RST_MODE_ENABLE        0x0008  /* EEPROM
> > SW RST enable flag */
> > +
> > +#define PCH_I2CSADR  0x00    /* I2C slave address register */
> > +#define PCH_I2CCTL   0x04    /* I2C control register */
> > +#define PCH_I2CSR    0x08    /* I2C status register */
> > +#define PCH_I2CDR    0x0C    /* I2C data register */
> > +#define PCH_I2CMON   0x10    /* I2C bus monitor register */
> > +#define PCH_I2CBC    0x14    /* I2C bus transfer rate setup counte=
r */
> > +#define PCH_I2CMOD   0x18    /* I2C mode register */
> > +#define PCH_I2CBUFSLV        0x1C    /* I2C buffer mode slave addr=
ess
> > register */
> > +#define PCH_I2CBUFSUB        0x20    /* I2C buffer mode subaddress=
 register
> > */
> > +#define PCH_I2CBUFFOR        0x24    /* I2C buffer mode format reg=
ister */
> > +#define PCH_I2CBUFCTL        0x28    /* I2C buffer mode control re=
gister */
> > +#define PCH_I2CBUFMSK        0x2C    /* I2C buffer mode interrupt =
mask
> > register */
> > +#define PCH_I2CBUFSTA        0x30    /* I2C buffer mode status reg=
ister */
> > +#define PCH_I2CBUFLEV        0x34    /* I2C buffer mode level regi=
ster */
> > +#define PCH_I2CESRFOR        0x38    /* EEPROM software reset mode
> > format register */
> > +#define PCH_I2CESRCTL        0x3C    /* EEPROM software reset mode=
 ctrl
> > register */
> > +#define PCH_I2CESRMSK        0x40    /* EEPROM software reset mode=
 */
> > +#define PCH_I2CESRSTA        0x44    /* EEPROM software reset mode
> > status register */
> > +#define PCH_I2CTMR   0x48    /* I2C timer register */
> > +#define PCH_I2CSRST  0xFC    /* I2C reset register */
> > +#define PCH_I2CNF    0xF8    /* I2C noise filter register */
> > +
> > +#define BUS_IDLE_TIMEOUT     20
> > +#define PCH_I2CCTL_I2CMEN    0x0080
> > +#define TEN_BIT_ADDR_DEFAULT 0xF000
> > +#define TEN_BIT_ADDR_MASK    0xF0
> > +#define PCH_START            0x0020
> > +#define PCH_ESR_START                0x0001
> > +#define PCH_BUFF_START               0x1
> > +#define PCH_REPSTART         0x0004
> > +#define PCH_ACK                      0x0008
> > +#define PCH_GETACK           0x0001
> > +#define CLR_REG                      0x0
> > +#define I2C_RD                       0x1
> > +#define I2CMCF_BIT           0x0080
> > +#define I2CMIF_BIT           0x0002
> > +#define I2CMAL_BIT           0x0010
> > +#define I2CBMFI_BIT          0x0001
> > +#define I2CBMAL_BIT          0x0002
> > +#define I2CBMNA_BIT          0x0004
> > +#define I2CBMTO_BIT          0x0008
> > +#define I2CBMIS_BIT          0x0010
> > +#define I2CESRFI_BIT         0X0001
> > +#define I2CESRTO_BIT         0x0002
> > +#define I2CESRFIIE_BIT               0x1
> > +#define I2CESRTOIE_BIT               0x2
> > +#define I2CBMDZ_BIT          0x0040
> > +#define I2CBMAG_BIT          0x0020
> > +#define I2CMBB_BIT           0x0020
> > +#define BUFFER_MODE_MASK     (I2CBMFI_BIT | I2CBMAL_BIT |
> > I2CBMNA_BIT | \
> > +                             I2CBMTO_BIT | I2CBMIS_BIT)
> > +#define I2C_ADDR_MSK         0xFF
> > +#define I2C_MSB_2B_MSK               0x300
> > +#define FAST_MODE_CLK                400
> > +#define FAST_MODE_EN         0x0001
> > +#define SUB_ADDR_LEN_MAX     4
> > +#define BUF_LEN_MAX          32
> > +#define PCH_BUFFER_MODE              0x1
> > +#define EEPROM_SW_RST_MODE   0x0002
> > +#define NORMAL_INTR_ENBL     0x0300
> > +#define EEPROM_RST_INTR_ENBL (I2CESRFIIE_BIT | I2CESRTOIE_BIT)
> > +#define EEPROM_RST_INTR_DISBL        0x0
> > +#define BUFFER_MODE_INTR_ENBL        0x001F
> > +#define BUFFER_MODE_INTR_DISBL       0x0
> > +#define NORMAL_MODE          0x0
> > +#define BUFFER_MODE          0x1
> > +#define EEPROM_SR_MODE               0x2
> > +#define I2C_TX_MODE          0x0010
> > +#define PCH_BUF_TX           0xFFF7
> > +#define PCH_BUF_RD           0x0008
> > +#define I2C_ERROR_MASK       (I2CESRTO_EVENT | I2CBMIS_EVENT |
> > I2CBMTO_EVENT | \
> > +                     I2CBMNA_EVENT | I2CBMAL_EVENT | I2CMAL_EVENT)
> > +#define I2CMAL_EVENT         0x0001
> > +#define I2CMCF_EVENT         0x0002
> > +#define I2CBMFI_EVENT                0x0004
> > +#define I2CBMAL_EVENT                0x0008
> > +#define I2CBMNA_EVENT                0x0010
> > +#define I2CBMTO_EVENT                0x0020
> > +#define I2CBMIS_EVENT                0x0040
> > +#define I2CESRFI_EVENT               0x0080
> > +#define I2CESRTO_EVENT               0x0100
> > +#define PCI_DEVICE_ID_PCH_I2C        0x8817
> > +
> > +#define pch_dbg(adap, fmt, arg...)  \
> > +     dev_dbg(adap->pch_adapter.dev.parent, "%s :" fmt, __func__, #=
#arg)
> > +
> > +#define pch_err(adap, fmt, arg...)  \
> > +     dev_err(adap->pch_adapter.dev.parent, "%s :" fmt, __func__, #=
#arg)
> > +
> > +#define pch_pci_err(pdev, fmt, arg...)  \
> > +     dev_err(&pdev->dev, "%s :" fmt, __func__, ##arg)
> > +
> > +#define pch_pci_dbg(pdev, fmt, arg...)  \
> > +     dev_dbg(&pdev->dev, "%s :" fmt, __func__, ##arg)
> > +
> > +/**
> > + * struct i2c_algo_pch_data - for I2C driver functionalities
> > + * @pch_adapter:             stores the reference to i2c_adapter s=
tructure
> > + * @p_adapter_info:          stores the reference to adapter_info =
structure
> > + * @pch_base_address:                specifies the remapped base a=
ddress
> > + * @pch_buff_mode_en:                specifies if buffer mode is e=
nabled
> > + * @pch_event_flag:          specifies occurrence of interrupt eve=
nts
> > + * @pch_i2c_xfer_in_progress:        specifies whether the transfe=
r is completed
> > + */
> > +struct i2c_algo_pch_data {
> > +     struct i2c_adapter pch_adapter;
> > +     struct adapter_info *p_adapter_info;
> > +     void __iomem *pch_base_address;
> > +     int pch_buff_mode_en;
> > +     u32 pch_event_flag;
> > +     bool pch_i2c_xfer_in_progress;
> > +};
> > +
> > +/**
> > + * struct adapter_info - This structure holds the adapter informat=
ion for the
> > +                      PCH i2c controller
> > + * @pch_data:                stores a list of i2c_algo_pch_data
> > + * @pch_i2c_suspended:       specifies whether the system is suspe=
nded or not
> > + *                   perhaps with more lines and words.
> > + *
> > + * pch_data has as many elements as maximum I2C channels
> > + */
> > +struct adapter_info {
> > +     struct i2c_algo_pch_data pch_data;
> > +     bool pch_i2c_suspended;
> > +};
> > +
> > +
> > +static int pch_i2c_speed =3D 100; /* I2C bus speed in Kbps */
> > +static int pch_clk =3D 50000;  /* specifies I2C clock speed in KHz=
 */
> > +static wait_queue_head_t pch_event;
> > +static DEFINE_MUTEX(pch_mutex);
> > +
> > +static struct pci_device_id __devinitdata pch_pcidev_id[] =3D {
> > +     {PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PCH_I2C)},
> > +     {0,}
> > +};
> > +
> > +static irqreturn_t pch_i2c_handler(int irq, void *pData);
> > +
> > +static inline void pch_setbit(void __iomem *addr, u32 offset, u32 =
bitmask)
> > +{
> > +     u32 val;
> > +     val =3D ioread32(addr + offset);
> > +     val |=3D bitmask;
> > +     iowrite32(val, addr + offset);
> > +}
> > +
> > +static inline void pch_clrbit(void __iomem *addr, u32 offset, u32 =
bitmask)
> > +{
> > +     u32 val;
> > +     val =3D ioread32(addr + offset);
> > +     val &=3D (~bitmask);
> > +     iowrite32(val, addr + offset);
> > +}
> > +
> > +/**
> > + * pch_i2c_init() - hardware initialization of I2C module
> > + * @adap:    Pointer to struct i2c_algo_pch_data.
> > + */
> > +static void pch_i2c_init(struct i2c_algo_pch_data *adap)
> > +{
> > +     void __iomem *p =3D adap->pch_base_address;
> > +     u32 pch_i2cbc;
> > +     u32 pch_i2ctmr;
> > +     u32 reg_value;
> > +
> > +     /* reset I2C controller */
> > +     iowrite32(0x01, p + PCH_I2CSRST);
> > +     msleep(20);
> > +     iowrite32(0x0, p + PCH_I2CSRST);
> > +
> > +     /* Initialize I2C registers */
> > +     iowrite32(0x21, p + PCH_I2CNF);
> > +
> > +     pch_setbit(adap->pch_base_address, PCH_I2CCTL,
> > +                       PCH_I2CCTL_I2CMEN);
> > +
> > +     if (pch_i2c_speed !=3D 400)
> > +             pch_i2c_speed =3D 100;
> > +
> > +     reg_value =3D PCH_I2CCTL_I2CMEN;
> > +     if (pch_i2c_speed =3D=3D FAST_MODE_CLK) {
> > +             reg_value |=3D FAST_MODE_EN;
> > +             pch_dbg(adap, "Fast mode enabled\n");
> > +     }
> > +
> > +     if (pch_clk > PCH_MAX_CLK)
> > +             pch_clk =3D 62500;
> > +
> > +     pch_i2cbc =3D (pch_clk + (pch_i2c_speed * 4)) / pch_i2c_speed=
 * 8;
> > +     /* Set transfer speed in I2CBC */
> > +     iowrite32(pch_i2cbc, p + PCH_I2CBC);
> > +
> > +     pch_i2ctmr =3D (pch_clk) / 8;
> > +     iowrite32(pch_i2ctmr, p + PCH_I2CTMR);
> > +
> > +     reg_value |=3D NORMAL_INTR_ENBL;  /* Enable interrupts in nor=
mal
> > mode */
> > +     iowrite32(reg_value, p + PCH_I2CCTL);
> > +
> > +     pch_dbg(adap,
> > +             "I2CCTL=3D%x pch_i2cbc=3D%x pch_i2ctmr=3D%x Enable in=
terrupts\n",
> > +             ioread32(p + PCH_I2CCTL), pch_i2cbc, pch_i2ctmr);
> > +
> > +     init_waitqueue_head(&pch_event);
> > +}
> > +
> > +static inline bool ktime_lt(const ktime_t cmp1, const ktime_t cmp2=
)
> > +{
> > +     return cmp1.tv64 < cmp2.tv64;
> > +}
> > +
> > +/**
> > + * pch_i2c_wait_for_bus_idle() - check the status of bus.
> > + * @adap:    Pointer to struct i2c_algo_pch_data.
> > + * @timeout: waiting time counter (us).
> > + */
> > +static s32 pch_i2c_wait_for_bus_idle(struct i2c_algo_pch_data *ada=
p,
> > +                              s32 timeout)
> > +{
> > +     void __iomem *p =3D adap->pch_base_address;
> > +
> > +     /* MAX timeout value is timeout*1000*1000nsec */
> > +     ktime_t ns_val =3D ktime_add_ns(ktime_get(), timeout*1000*100=
0);
> > +     do {
> > +             if ((ioread32(p + PCH_I2CSR) & I2CMBB_BIT) =3D=3D 0)
> > +                     break;
> > +             msleep(20);
> > +     } while (ktime_lt(ktime_get(), ns_val));
> > +
> > +     pch_dbg(adap, "I2CSR =3D %x\n", ioread32(p + PCH_I2CSR));
> > +
> > +     if (timeout =3D=3D 0) {
> > +             pch_err(adap, "%s: Timeout Error.return%d\n", __func_=
_, -ETIME);
> > +             return -ETIME;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * pch_i2c_start() - Generate I2C start condition in normal mode.
> > + * @adap:    Pointer to struct i2c_algo_pch_data.
> > + *
> > + * Generate I2C start condition in normal mode by setting I2CCTL.I=
2CMSTA to
> > 1.
> > + */
> > +static void pch_i2c_start(struct i2c_algo_pch_data *adap)
> > +{
> > +     void __iomem *p =3D adap->pch_base_address;
> > +     pch_dbg(adap, "I2CCTL =3D %x\n", ioread32(p + PCH_I2CCTL));
> > +     pch_setbit(adap->pch_base_address, PCH_I2CCTL, PCH_START);
> > +}
> > +
> > +/**
> > + * pch_i2c_wait_for_xfer_complete() - initiates a wait for the tx =
complete
> > event
> > + * @adap:    Pointer to struct i2c_algo_pch_data.
> > + */
> > +static s32 pch_i2c_wait_for_xfer_complete(struct i2c_algo_pch_data=
 *adap)
> > +{
> > +     s32 ret;
> > +     ret =3D wait_event_timeout(pch_event,
> > +                     (adap->pch_event_flag !=3D 0), msecs_to_jiffi=
es(50));
> > +     if (ret < 0) {
> > +             pch_err(adap, "timeout: %x\n", adap->pch_event_flag);
> > +             return ret;
> > +     }
> > +
> > +     if (ret =3D=3D 0) {
> > +             pch_err(adap, "timeout: %x\n", adap->pch_event_flag);
> > +             return -ETIMEDOUT;
> > +     }
> > +
> > +     if (adap->pch_event_flag & I2C_ERROR_MASK) {
> > +             pch_err(adap, "error bits set: %x\n", adap->pch_event=
_flag);
> > +             return -EIO;
> > +     }
> > +
> > +     adap->pch_event_flag =3D 0;
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * pch_i2c_getack() - to confirm ACK/NACK
> > + * @adap:    Pointer to struct i2c_algo_pch_data.
> > + */
> > +static s32 pch_i2c_getack(struct i2c_algo_pch_data *adap)
> > +{
> > +     u32 reg_val;
> > +     void __iomem *p =3D adap->pch_base_address;
> > +     reg_val =3D ioread32(p + PCH_I2CSR) & PCH_GETACK;
> > +
> > +     if (reg_val !=3D 0) {
> > +             pch_err(adap, "return%d\n", -EPROTO);
> > +             return -EPROTO;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * pch_i2c_stop() - generate stop condition in normal mode.
> > + * @adap:    Pointer to struct i2c_algo_pch_data.
> > + */
> > +static void pch_i2c_stop(struct i2c_algo_pch_data *adap)
> > +{
> > +     void __iomem *p =3D adap->pch_base_address;
> > +     pch_dbg(adap, "I2CCTL =3D %x\n", ioread32(p + PCH_I2CCTL));
> > +     /* clear the start bit */
> > +     pch_clrbit(adap->pch_base_address, PCH_I2CCTL, PCH_START);
> > +}
> > +
> > +/**
> > + * pch_i2c_repstart() - generate repeated start condition in norma=
l mode
> > + * @adap:    Pointer to struct i2c_algo_pch_data.
> > + */
> > +static void pch_i2c_repstart(struct i2c_algo_pch_data *adap)
> > +{
> > +     void __iomem *p =3D adap->pch_base_address;
> > +     pch_dbg(adap, "I2CCTL =3D %x\n", ioread32(p + PCH_I2CCTL));
> > +     pch_setbit(adap->pch_base_address, PCH_I2CCTL, PCH_REPSTART);
> > +}
> > +
> > +/**
> > + * pch_i2c_writebytes() - write data to I2C bus in normal mode
> > + * @i2c_adap:        Pointer to the struct i2c_adapter.
> > + * @last:    specifies whether last message or not.
> > + *           In the case of compound mode it will be 1 for last me=
ssage,
> > + *           otherwise 0.
> > + * @first:   specifies whether first message or not.
> > + *           1 for first message otherwise 0.
> > + */
> > +static s32 pch_i2c_writebytes(struct i2c_adapter *i2c_adap,
> > +                           struct i2c_msg *msgs, u32 last, u32 fir=
st)
> > +{
> > +     struct i2c_algo_pch_data *adap =3D i2c_adap->algo_data;
> > +     u8 *buf;
> > +     u32 length;
> > +     u32 addr;
> > +     u32 addr_2_msb;
> > +     u32 addr_8_lsb;
> > +     s32 wrcount;
> > +     void __iomem *p =3D adap->pch_base_address;
> > +
> > +     length =3D msgs->len;
> > +     buf =3D msgs->buf;
> > +     addr =3D msgs->addr;
> > +
> > +     /* enable master tx */
> > +     pch_setbit(adap->pch_base_address, PCH_I2CCTL, I2C_TX_MODE);
> > +
> > +     pch_dbg(adap, "I2CCTL =3D %x msgs->len =3D %d\n", ioread32(p =
+
> > PCH_I2CCTL),
> > +             length);
> > +
> > +     if (first) {
> > +             if (pch_i2c_wait_for_bus_idle(adap, BUS_IDLE_TIMEOUT)=
 =3D=3D -ETIME)
> > +                     return -ETIME;
> > +     }
> > +
> > +     if (msgs->flags & I2C_M_TEN) {
> > +             addr_2_msb =3D ((addr & I2C_MSB_2B_MSK) >> 7);
> > +             iowrite32(addr_2_msb | TEN_BIT_ADDR_MASK, p + PCH_I2C=
DR);
> > +             if (first)
> > +                     pch_i2c_start(adap);
> > +             if (pch_i2c_wait_for_xfer_complete(adap) =3D=3D 0 &&
> > +                 pch_i2c_getack(adap) =3D=3D 0) {
> > +                     addr_8_lsb =3D (addr & I2C_ADDR_MSK);
> > +                     iowrite32(addr_8_lsb, p + PCH_I2CDR);
> > +             } else {
> > +                     pch_i2c_stop(adap);
> > +                     return -ETIME;
> > +             }
> > +     } else {
> > +             /* set 7 bit slave address and R/W bit as 0 */
> > +             iowrite32(addr << 1, p + PCH_I2CDR);
> > +             if (first)
> > +                     pch_i2c_start(adap);
> > +     }
> > +
> > +     if ((pch_i2c_wait_for_xfer_complete(adap) =3D=3D 0) &&
> > +         (pch_i2c_getack(adap) =3D=3D 0)) {
> > +             for (wrcount =3D 0; wrcount < length; ++wrcount) {
> > +                     /* write buffer value to I2C data register */
> > +                     iowrite32(buf[wrcount], p + PCH_I2CDR);
> > +                     pch_dbg(adap, "writing %x to Data register\n"=
,
> > +                             buf[wrcount]);
> > +
> > +                     if (pch_i2c_wait_for_xfer_complete(adap) !=3D=
 0)
> > +                             return -ETIME;
> > +
> > +                     if (pch_i2c_getack(adap))
> > +                             return -EIO;
> > +             }
> > +
> > +             /* check if this is the last message */
> > +             if (last)
> > +                     pch_i2c_stop(adap);
> > +             else
> > +                     pch_i2c_repstart(adap);
> > +     } else {
> > +             pch_i2c_stop(adap);
> > +             return -EIO;
> > +     }
> > +
> > +     pch_dbg(adap, "return=3D%d\n", wrcount);
> > +
> > +     return wrcount;
> > +}
> > +
> > +/**
> > + * pch_i2c_sendack() - send ACK
> > + * @adap:    Pointer to struct i2c_algo_pch_data.
> > + */
> > +static void pch_i2c_sendack(struct i2c_algo_pch_data *adap)
> > +{
> > +     void __iomem *p =3D adap->pch_base_address;
> > +     pch_dbg(adap, "I2CCTL =3D %x\n", ioread32(p + PCH_I2CCTL));
> > +     pch_clrbit(adap->pch_base_address, PCH_I2CCTL, PCH_ACK);
> > +}
> > +
> > +/**
> > + * pch_i2c_sendnack() - send NACK
> > + * @adap:    Pointer to struct i2c_algo_pch_data.
> > + */
> > +static void pch_i2c_sendnack(struct i2c_algo_pch_data *adap)
> > +{
> > +     void __iomem *p =3D adap->pch_base_address;
> > +     pch_dbg(adap, "I2CCTL =3D %x\n", ioread32(p + PCH_I2CCTL));
> > +     pch_setbit(adap->pch_base_address, PCH_I2CCTL, PCH_ACK);
> > +}
> > +
> > +/**
> > + * pch_i2c_readbytes() - read data  from I2C bus in normal mode.
> > + * @i2c_adap:        Pointer to the struct i2c_adapter.
> > + * @msgs:    Pointer to i2c_msg structure.
> > + * @last:    specifies whether last message or not.
> > + * @first:   specifies whether first message or not.
> > + */
> > +s32 pch_i2c_readbytes(struct i2c_adapter *i2c_adap, struct i2c_msg=
 *msgs,
> > +               u32 last, u32 first)
> > +{
> > +     struct i2c_algo_pch_data *adap =3D i2c_adap->algo_data;
> > +
> > +     u8 *buf;
> > +     u32 count;
> > +     u32 length;
> > +     u32 addr;
> > +     u32 addr_2_msb;
> > +     void __iomem *p =3D adap->pch_base_address;
> > +
> > +     length =3D msgs->len;
> > +     buf =3D msgs->buf;
> > +     addr =3D msgs->addr;
> > +
> > +     /* enable master reception */
> > +     pch_clrbit(adap->pch_base_address, PCH_I2CCTL, I2C_TX_MODE);
> > +
> > +     if (first) {
> > +             if (pch_i2c_wait_for_bus_idle(adap, BUS_IDLE_TIMEOUT)=
 =3D=3D -ETIME)
> > +                     return -ETIME;
> > +     }
> > +
> > +     if (msgs->flags & I2C_M_TEN) {
> > +             addr_2_msb =3D (((addr & I2C_MSB_2B_MSK) >> 7) | (I2C=
_RD));
> > +             iowrite32(addr_2_msb | TEN_BIT_ADDR_MASK, p + PCH_I2C=
DR);
> > +
> > +     } else {
> > +             /* 7 address bits + R/W bit */
> > +             addr =3D (((addr) << 1) | (I2C_RD));
> > +             iowrite32(addr, p + PCH_I2CDR);
> > +     }
> > +
> > +     /* check if it is the first message */
> > +     if (first)
> > +             pch_i2c_start(adap);
> > +
> > +     if ((pch_i2c_wait_for_xfer_complete(adap) =3D=3D 0) &&
> > +         (pch_i2c_getack(adap) =3D=3D 0)) {
> > +             pch_dbg(adap, "return %d\n", 0);
> > +
> > +             if (length =3D=3D 0) {
> > +                     pch_i2c_stop(adap);
> > +                     ioread32(p + PCH_I2CDR); /* Dummy read needs =
*/
> > +
> > +                     count =3D length;
> > +             } else {
> > +                     int read_index;
> > +                     int loop;
> > +                     pch_i2c_sendack(adap);
> > +
> > +                     /* Dummy read */
> > +                     for (loop =3D 1, read_index =3D 0; loop < len=
gth; loop++) {
> > +                             buf[read_index] =3D ioread32(p + PCH_=
I2CDR);
> > +
> > +                             if (loop !=3D 1)
> > +                                     read_index++;
> > +
> > +                             if (pch_i2c_wait_for_xfer_complete(ad=
ap) !=3D 0) {
> > +                                     pch_i2c_stop(adap);
> > +                                     return -ETIME;
> > +                             }
> > +                     }       /* end for */
> > +
> > +                     pch_i2c_sendnack(adap);
> > +
> > +                     buf[read_index] =3D ioread32(p + PCH_I2CDR);
> > +
> > +                     if (length !=3D 1)
> > +                             read_index++;
> > +
> > +                     if (pch_i2c_wait_for_xfer_complete(adap) =3D=3D=
 0) {
> > +                             if (last)
> > +                                     pch_i2c_stop(adap);
> > +                             else
> > +                                     pch_i2c_repstart(adap);
> > +
> > +                             buf[read_index++] =3D ioread32(p + PC=
H_I2CDR);
> > +                             count =3D read_index;
> > +                     } else {
> > +                             count =3D -ETIME;
> > +                     }
> > +
> > +             }
> > +     } else {
> > +             count =3D -ETIME;
> > +             pch_i2c_stop(adap);
> > +     }
> > +
> > +     return count;
> > +}
> > +
> > +/**
> > + * pch_i2c_cb_ch0() - Interrupt handler Call back function
> > + * @adap:    Pointer to struct i2c_algo_pch_data.
> > + */
> > +static void pch_i2c_cb_ch0(struct i2c_algo_pch_data *adap)
> > +{
> > +     u32 sts;
> > +     void __iomem *p =3D adap->pch_base_address;
> > +
> > +     sts =3D ioread32(p + PCH_I2CSR);
> > +     sts &=3D (I2CMAL_BIT | I2CMCF_BIT | I2CMIF_BIT);
> > +     if (sts & I2CMAL_BIT)
> > +             adap->pch_event_flag |=3D I2CMAL_EVENT;
> > +
> > +     if (sts & I2CMCF_BIT)
> > +             adap->pch_event_flag |=3D I2CMCF_EVENT;
> > +
> > +     /* clear the applicable bits */
> > +     pch_clrbit(adap->pch_base_address, PCH_I2CSR, sts);
> > +
> > +     pch_dbg(adap, "PCH_I2CSR =3D %x\n", ioread32(p + PCH_I2CSR));
> > +
> > +     wake_up(&pch_event);
> > +}
> > +
> > +/**
> > + * pch_i2c_handler() - interrupt handler for the PCH I2C controlle=
r
> > + * @irq:     irq number.
> > + * @pData:   cookie passed back to the handler function.
> > + */
> > +static irqreturn_t pch_i2c_handler(int irq, void *pData)
> > +{
> > +     s32 reg_val;
> > +
> > +     struct i2c_algo_pch_data *adap_data =3D (struct i2c_algo_pch_=
data
> > *)pData;
> > +     void __iomem *p =3D adap_data->pch_base_address;
> > +     u32 mode =3D ioread32(p + PCH_I2CMOD) & (BUFFER_MODE |
> > EEPROM_SR_MODE);
> > +
> > +     if (mode !=3D NORMAL_MODE) {
> > +             pch_err(adap_data, "I2C mode is not supported\n");
> > +             return IRQ_NONE;
> > +     }
> > +
> > +     reg_val =3D ioread32(p + PCH_I2CSR);
> > +     if (reg_val & (I2CMAL_BIT | I2CMCF_BIT | I2CMIF_BIT))
> > +             pch_i2c_cb_ch0(adap_data);
> > +     else
> > +             return IRQ_NONE;
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +/**
> > + * pch_i2c_xfer() - Reading adnd writing data through I2C bus
> > + * @i2c_adap:        Pointer to the struct i2c_adapter.
> > + * @msgs:    Pointer to i2c_msg structure.
> > + * @num:     number of messages.
> > + */
> > +static s32 pch_i2c_xfer(struct i2c_adapter *i2c_adap,
> > +                 struct i2c_msg *msgs, s32 num)
> > +{
> > +     struct i2c_msg *pmsg;
> > +     u32 i =3D 0;
> > +     u32 status;
> > +     u32 msglen;
> > +     u32 subaddrlen;
> > +     s32 ret;
> > +
> > +     struct i2c_algo_pch_data *adap =3D i2c_adap->algo_data;
> > +
> > +     ret =3D mutex_lock_interruptible(&pch_mutex);
> > +     if (ret)
> > +             return -ERESTARTSYS;
> > +
> > +     if (adap->p_adapter_info->pch_i2c_suspended) {
> > +             mutex_unlock(&pch_mutex);
> > +             return -EBUSY;
> > +     }
> > +
> > +     pch_dbg(adap, "adap->p_adapter_info->pch_i2c_suspended is %d\=
n",
> > +             adap->p_adapter_info->pch_i2c_suspended);
> > +     /* transfer not completed */
> > +     adap->pch_i2c_xfer_in_progress =3D true;
> > +
> > +     pmsg =3D &msgs[0];
> > +     pmsg->flags |=3D adap->pch_buff_mode_en;
> > +     status =3D pmsg->flags;
> > +     pch_dbg(adap,
> > +             "After invoking I2C_MODE_SEL :flag=3D 0x%x\n", status=
);
> > +     /* calculate sub address length and message length */
> > +     /* these are applicable only for buffer mode */
> > +     subaddrlen =3D pmsg->buf[0];
> > +     /* calculate actual message length excluding
> > +      * the sub address fields */
> > +     msglen =3D (pmsg->len) - (subaddrlen + 1);
> > +     if (status & (I2C_M_RD)) {
> > +             pch_dbg(adap, "invoking pch_i2c_readbytes\n");
> > +             ret =3D pch_i2c_readbytes(i2c_adap, pmsg, (i + 1 =3D=3D=
 num),
> > +                                (i =3D=3D 0));
> > +     } else {
> > +             pch_dbg(adap, "invoking pch_i2c_writebytes\n");
> > +             ret =3D pch_i2c_writebytes(i2c_adap, pmsg, (i + 1 =3D=
=3D num),
> > +                                 (i =3D=3D 0));
> > +     }
> > +
> > +     adap->pch_i2c_xfer_in_progress =3D false; /* transfer complet=
ed */
> > +
> > +     mutex_unlock(&pch_mutex);
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> > + * pch_i2c_func() - return the functionality of the I2C driver
> > + * @adap:    Pointer to struct i2c_algo_pch_data.
> > + */
> > +static u32 pch_i2c_func(struct i2c_adapter *adap)
> > +{
> > +     return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
> > I2C_FUNC_10BIT_ADDR;
> > +}
> > +
> > +static struct i2c_algorithm pch_algorithm =3D {
> > +     .master_xfer =3D pch_i2c_xfer,
> > +     .functionality =3D pch_i2c_func
> > +};
> > +
> > +/**
> > + * pch_i2c_disbl_int() - Disable PCH I2C interrupts
> > + * @adap:    Pointer to struct i2c_algo_pch_data.
> > + */
> > +static void pch_i2c_disbl_int(struct i2c_algo_pch_data *adap)
> > +{
> > +     void __iomem *p =3D adap->pch_base_address;
> > +
> > +     pch_clrbit(adap->pch_base_address, PCH_I2CCTL,
> > NORMAL_INTR_ENBL);
> > +
> > +     iowrite32(EEPROM_RST_INTR_DISBL, p + PCH_I2CESRMSK);
> > +
> > +     iowrite32(BUFFER_MODE_INTR_DISBL, p + PCH_I2CBUFMSK);
> > +}
> > +
> > +static int __devinit pch_i2c_probe(struct pci_dev *pdev,
> > +                            const struct pci_device_id *id)
> > +{
> > +     void __iomem *base_addr;
> > +     s32 ret;
> > +     struct adapter_info *adap_info;
> > +
> > +     pch_pci_dbg(pdev, "Entered.\n");
> > +
> > +     adap_info =3D kzalloc((sizeof(struct adapter_info)), GFP_KERN=
EL);
> > +     if (adap_info =3D=3D NULL) {
> > +             pch_pci_err(pdev, "Memory allocation FAILED\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     ret =3D pci_enable_device(pdev);
> > +     if (ret) {
> > +             pch_pci_err(pdev, "pci_enable_device FAILED\n");
> > +             goto err_pci_enable;
> > +     }
> > +
> > +     ret =3D pci_request_regions(pdev, KBUILD_MODNAME);
> > +     if (ret) {
> > +             pch_pci_err(pdev, "pci_request_regions FAILED\n");
> > +             goto err_pci_req;
> > +     }
> > +
> > +     base_addr =3D pci_iomap(pdev, 1, 0);
> > +
> > +     if (base_addr =3D=3D NULL) {
> > +             pch_pci_err(pdev, "pci_iomap FAILED\n");
> > +             ret =3D -ENOMEM;
> > +             goto err_pci_iomap;
> > +     }
> > +
> > +     adap_info->pch_i2c_suspended =3D false;
> > +
> > +     adap_info->pch_data.p_adapter_info =3D adap_info;
> > +
> > +     adap_info->pch_data.pch_adapter.owner =3D THIS_MODULE;
> > +     adap_info->pch_data.pch_adapter.class =3D I2C_CLASS_HWMON;
> > +     strcpy(adap_info->pch_data.pch_adapter.name, KBUILD_MODNAME);
> > +     adap_info->pch_data.pch_adapter.algo =3D &pch_algorithm;
> > +     adap_info->pch_data.pch_adapter.algo_data =3D
> > +                                             &adap_info->pch_data;
> > +
> > +     /* (i * 0x80) + base_addr; */
> > +     adap_info->pch_data.pch_base_address =3D base_addr;
> > +
> > +     adap_info->pch_data.pch_adapter.dev.parent =3D &pdev->dev;
> > +
> > +     ret =3D i2c_add_adapter(&(adap_info->pch_data.pch_adapter));
> > +
> > +     if (ret) {
> > +             pch_pci_err(pdev, "i2c_add_adapter FAILED\n");
> > +             goto err_i2c_add_adapter;
> > +     }
> > +
> > +     pch_i2c_init(&adap_info->pch_data);
> > +     ret =3D request_irq(pdev->irq, pch_i2c_handler, IRQF_SHARED,
> > +               KBUILD_MODNAME, &adap_info->pch_data);
> > +     if (ret) {
> > +             pch_pci_err(pdev, "request_irq FAILED\n");
> > +             goto err_request_irq;
> > +     }
> > +
> > +     pci_set_drvdata(pdev, adap_info);
> > +     pch_pci_dbg(pdev, "returns %d.\n", ret);
> > +     return 0;
> > +
> > +err_request_irq:
> > +     i2c_del_adapter(&(adap_info->pch_data.pch_adapter));
> > +err_i2c_add_adapter:
> > +     pci_iounmap(pdev, base_addr);
> > +err_pci_iomap:
> > +     pci_release_regions(pdev);
> > +err_pci_req:
> > +     pci_disable_device(pdev);
> > +err_pci_enable:
> > +     kfree(adap_info);
> > +     return ret;
> > +}
> > +
> > +static void __devexit pch_i2c_remove(struct pci_dev *pdev)
> > +{
> > +     struct adapter_info *adap_info =3D pci_get_drvdata(pdev);
> > +
> > +     pch_i2c_disbl_int(&adap_info->pch_data);
> > +     free_irq(pdev->irq, &adap_info->pch_data);
> > +     i2c_del_adapter(&(adap_info->pch_data.pch_adapter));
> > +
> > +     if (adap_info->pch_data.pch_base_address) {
> > +             pci_iounmap(pdev, adap_info->pch_data.pch_base_addres=
s);
> > +             adap_info->pch_data.pch_base_address =3D 0;
> > +     }
> > +
> > +     pci_set_drvdata(pdev, NULL);
> > +
> > +     pci_release_regions(pdev);
> > +
> > +     pci_disable_device(pdev);
> > +     kfree(adap_info);
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int pch_i2c_suspend(struct pci_dev *pdev, pm_message_t stat=
e)
> > +{
> > +     int ret;
> > +     struct adapter_info *adap_info =3D pci_get_drvdata(pdev);
> > +     void __iomem *p =3D adap_info->pch_data.pch_base_address;
> > +
> > +     adap_info->pch_i2c_suspended =3D true;
> > +
> > +     while ((adap_info->pch_data.pch_i2c_xfer_in_progress)) {
> > +             /* Wait until all channel transfers are completed */
> > +             msleep(20);
> > +     }
> > +     /* Disable the i2c interrupts */
> > +     pch_i2c_disbl_int(&adap_info->pch_data);
> > +
> > +     pch_pci_dbg(pdev, "I2CSR =3D %x I2CBUFSTA =3D %x I2CESRSTA =3D=
 %x "
> > +             "invoked function pch_i2c_disbl_int successfully\n",
> > +             ioread32(p + PCH_I2CSR), ioread32(p + PCH_I2CBUFSTA),
> > +             ioread32(p + PCH_I2CESRSTA));
> > +
> > +     ret =3D pci_save_state(pdev);
> > +
> > +     if (ret) {
> > +             pch_pci_err(pdev, "pci_save_state\n");
> > +             return ret;
> > +     }
> > +
> > +     pci_enable_wake(pdev, PCI_D3hot, 0);
> > +     pci_disable_device(pdev);
> > +     pci_set_power_state(pdev, pci_choose_state(pdev, state));
> > +
> > +     return 0;
> > +}
> > +
> > +static int pch_i2c_resume(struct pci_dev *pdev)
> > +{
> > +     struct adapter_info *adap_info =3D pci_get_drvdata(pdev);
> > +
> > +     pci_set_power_state(pdev, PCI_D0);
> > +     pci_restore_state(pdev);
> > +
> > +     if (pci_enable_device(pdev) < 0) {
> > +             pch_pci_err(pdev, "pch_i2c_resume:pci_enable_device F=
AILED\n");
> > +             return -EIO;
> > +     }
> > +
> > +     pci_enable_wake(pdev, PCI_D3hot, 0);
> > +
> > +     pch_i2c_init(&adap_info->pch_data);
> > +
> > +     adap_info->pch_i2c_suspended =3D false;
> > +
> > +     return 0;
> > +}
> > +#else
> > +#define pch_i2c_suspend NULL
> > +#define pch_i2c_resume NULL
> > +#endif
> > +
> > +static struct pci_driver pch_pcidriver =3D {
> > +     .name =3D KBUILD_MODNAME,
> > +     .id_table =3D pch_pcidev_id,
> > +     .probe =3D pch_i2c_probe,
> > +     .remove =3D __devexit_p(pch_i2c_remove),
> > +     .suspend =3D pch_i2c_suspend,
> > +     .resume =3D pch_i2c_resume
> > +};
> > +
> > +static int __init pch_pci_init(void)
> > +{
> > +     return pci_register_driver(&pch_pcidriver);
> > +}
> > +module_init(pch_pci_init);
> > +
> > +static void __exit pch_pci_exit(void)
> > +{
> > +     pci_unregister_driver(&pch_pcidriver);
> > +}
> > +module_exit(pch_pci_exit);
> > +
> > +MODULE_DESCRIPTION("PCH I2C PCI Driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Tomoya MORINAGA.
> > <tomoya-linux-ECg8zkTtlr0C6LszWs/t0g@public.gmane.org>");
> > +module_param(pch_i2c_speed, int, (S_IRUSR | S_IWUSR));
> > +module_param(pch_clk, int, (S_IRUSR | S_IWUSR));
> > --
> > 1.6.0.6
> [Erreur de d=E9codage BASE64]


--=20
Jean Delvare
