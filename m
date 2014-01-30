From: Tejun Heo <tj@kernel.org>
Subject: Re: kernfs oops with i915+i2c_core in 3.14 merge window
Date: Thu, 30 Jan 2014 14:05:13 -0500
Message-ID: <20140130190513.GB16260@htj.dyndns.org>
References: <CA+5PVA4Oj7XOZSEYqXGE7ZPVVK1oEHEc-w_DniCediWGVhrmhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <CA+5PVA4Oj7XOZSEYqXGE7ZPVVK1oEHEc-w_DniCediWGVhrmhQ@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, DRI mailing list <dri-devel@lists.freedesktop.org>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 30, 2014 at 02:03:18PM -0500, Josh Boyer wrote:
> Hi All,
> 
> I'm seeing the oops below on my MacBookPro 10,2 machine using i915
> graphics.  It's after the DRM merge for 3.14 ( v3.13-10094-g9b0cd30) ,
> but we seem to have one report[1] of this happening well before that,
> in v3.13-3260-g03d11a0 as well.  Does anyone have a clue what is going
> on here?
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1055105

Should be fixed by the following patch which is already queued.

 http://lkml.kernel.org/g/20140129170403.GJ30842@htj.dyndns.org

Thanks.

-- 
tejun
