                
                
DefinitionBlock ("", "SSDT", 2, "DRTNIA", "PMCR", 0x00001000)
{
    External (_SB_.PCI0.LPCB, DeviceObj)
    Scope (\_SB.PCI0.LPCB)
    {
        Method (_DSM, 4, NotSerialized)
        {
            If (LEqual (Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
            Return (Package()
            {
                "compatible", "pci8086,9cc1",
            })
        }
    }
}