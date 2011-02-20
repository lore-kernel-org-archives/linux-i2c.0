From: Ben Dooks <ben-i2c@fluff.org>
Subject: Re: [PATCH] i2c-ocores: register devices on child nodes
Date: Sun, 20 Feb 2011 23:28:08 +0000
Message-ID: <20110220232808.GL15795@trinity.fluff.org>
References: <1297306314-11483-1-git-send-email-thomas@wytron.com.tw> <20110216043540.GB11684@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110216043540.GB11684@angua.secretlab.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Thomas Chou <thomas@wytron.com.tw>, Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, devicetree-discuss@lists.ozlabs.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 15, 2011 at 09:35:40PM -0700, Grant Likely wrote:
> On Thu, Feb 10, 2011 at 10:51:54AM +0800, Thomas Chou wrote:
> > This patch registers devices on the devicetree child nodes to the bus.
> > Also removes one trailing whitespace.
> > 
> > Signed-off-by: Thomas Chou <thomas@wytron.com.tw>
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Ben, do you want to pick this one up?  Or should I merge it via my
> devicetree branch?

If it applies to the mainline kernel, then I'll take it. 

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
