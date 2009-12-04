From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: [PATCH v2 1/2] acpi: support IBM SMBus CMI devices
Date: Fri, 4 Dec 2009 09:06:21 -0800
Message-ID: <20091204170621.GA10356@tux1.beaverton.ibm.com>
References: <20091021173733.GN26149@tux1.beaverton.ibm.com> <20091022071748.GA17917@crane-desktop> <20091022174304.GO26149@tux1.beaverton.ibm.com> <20091023044451.GB1367@crane-desktop> <20091023170311.GC21723@tux1.beaverton.ibm.com> <20091025125353.55d3bfad@hyperion.delvare> <20091026205819.GR26149@tux1.beaverton.ibm.com> <20091027180332.62f2c758@hyperion.delvare> <20091027173001.GT26149@tux1.beaverton.ibm.com> <20091027183619.16b0b952@hyperion.delvare>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932110AbZLDRGU@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091027183619.16b0b952@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, lenb@kernel.org
Cc: Crane Cai <crane.cai@amd.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, Jean Delvare <khali@linux-fr.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 27, 2009 at 06:36:19PM +0100, Jean Delvare wrote:
> On Tue, 27 Oct 2009 10:30:01 -0700, Darrick J. Wong wrote:
> > On Tue, Oct 27, 2009 at 06:03:32PM +0100, Jean Delvare wrote:
> > 
> > > I'm only half please with this. You change the function named, but it
> > > doesn't follow the calling convention of acpi_dock_match(), which is a
> > > little confusing.
> > > 
> > > Anyway, I will need an ack from the ACPI people before I can pick this
> > > patch. Or maybe they should even push it upstream themselves.

Len/Bjorn: Any opinion on this ACPI quirk patch to make i2c-scmi work on IBM
systems?  I think the i2c-scmi part is in Jean's tree, but I still need this
second patch to the ACPI code itself.  Did you pick it up, or should I resend?

--D
