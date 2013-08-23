From: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbWlzYzogKGF0MjQpIG1vdmUgaGVhZGVyIHRvIGxpbnV4?=
 =?UTF-8?B?L3BsYXRmb3JtX2RhdGEv?=
Date: Fri, 23 Aug 2013 23:26:36 +0400
Message-ID: <1377285996.620418788@f48.i.mail.ru>
References: <20130823190247.GA3821@katana>
 <1033284781.908504.1377285587778.JavaMail.root@mail>
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1033284781.908504.1377285587778.JavaMail.root@mail>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?B?Vml2aWVuIERpZGVsb3Q=?= <vivien.didelot@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?B?V29sZnJhbSBTYW5n?= <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

> Wolfram wrote:
> 
> > On Fri, Aug 23, 2013 at 02:38:20PM -0400, Vivien Didelot wrote:
> > > This patch moves the at24.h header from include/linux/i2c to
> > > include/linux/platform_data and updates existing support
> > > accordingly.
> > 
> > This message explains what the patch does but not why the change is
> > wanted. I'd be surprised if we really want *all* platform_data in one
> > single directory?
> 
> IMHO it makes sense. Why wouldn't we want all platform_data in
> include/linux/platform_data/?

Can this file be additionally renamed to misc-at24.h to reflect belongs
to a particular subsystem?

---
