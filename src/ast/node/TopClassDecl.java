/* This file was generated by SableCC (http://www.sablecc.org/). 
 * Then modified.
 */

package ast.node;

import ast.visitor.*;
import java.util.*;

@SuppressWarnings("nls")
public final class TopClassDecl extends IClassDecl
{
    private String _name_;
    private final LinkedList<VarDecl> _varDecls_ = new LinkedList<VarDecl>();
    private final LinkedList<MethodDecl> _methodDecls_ = new LinkedList<MethodDecl>();

    public TopClassDecl(int _line_, int _pos_, 
            String _name_, List<VarDecl> _varDecls_,
            List<MethodDecl> _methodDecls_)
    {
        super(_line_, _pos_);

        setName(_name_);

        setVarDecls(_varDecls_);

        setMethodDecls(_methodDecls_);

    }

    @Override
    public int getNumExpChildren() { return 0; }
    
    @Override
    public Object clone()
    {
        return new TopClassDecl(
                this.getLine(),
                this.getPos(),
                this._name_,
                cloneList(this._varDecls_),
                cloneList(this._methodDecls_));
    }

    public void accept(Visitor v)
    {
        v.visitTopClassDecl(this);
    }

    public String getName()
    {
        return this._name_;
    }

    public void setName(String name)
    {
        this._name_ = name;
    }

    public LinkedList<VarDecl> getVarDecls()
    {
        return this._varDecls_;
    }

    public void setVarDecls(List<VarDecl> list)
    {
        this._varDecls_.clear();
        this._varDecls_.addAll(list);
        for(VarDecl e : list)
        {
            if(e.parent() != null)
            {
                e.parent().removeChild(e);
            }

            e.parent(this);
        }
    }

    public LinkedList<MethodDecl> getMethodDecls()
    {
        return this._methodDecls_;
    }

    public void setMethodDecls(List<MethodDecl> list)
    {
        this._methodDecls_.clear();
        this._methodDecls_.addAll(list);
        for(MethodDecl e : list)
        {
            if(e.parent() != null)
            {
                e.parent().removeChild(e);
            }

            e.parent(this);
        }
    }

    @Override
    void removeChild(Node child)
    {
        // Remove child
        if(this._varDecls_.remove(child))
        {
            return;
        }

        if(this._methodDecls_.remove(child))
        {
            return;
        }

        throw new RuntimeException("Not a child.");
    }

    @Override
    void replaceChild(Node oldChild, Node newChild)
    {
        // Replace child
        for(ListIterator<VarDecl> i = this._varDecls_.listIterator(); i.hasNext();)
        {
            if(i.next() == oldChild)
            {
                if(newChild != null)
                {
                    i.set((VarDecl) newChild);
                    newChild.parent(this);
                    oldChild.parent(null);
                    return;
                }

                i.remove();
                oldChild.parent(null);
                return;
            }
        }

        for(ListIterator<MethodDecl> i = this._methodDecls_.listIterator(); i.hasNext();)
        {
            if(i.next() == oldChild)
            {
                if(newChild != null)
                {
                    i.set((MethodDecl) newChild);
                    newChild.parent(this);
                    oldChild.parent(null);
                    return;
                }

                i.remove();
                oldChild.parent(null);
                return;
            }
        }

        throw new RuntimeException("Not a child.");
    }
}
