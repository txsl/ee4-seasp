function [ ] = txsl_export_fig( outname )

tightfig;
export_fig(outname, '-pdf', gcf, '-nocrop', '-transparent', '-painters');

end

